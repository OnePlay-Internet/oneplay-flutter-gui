import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/client_token_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_status_model.dart';
import 'package:oneplay_flutter_gui/app/models/start_game_model.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/initialize_state.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';

class Game extends StatefulWidget {
  final String id;

  const Game(this.id, {super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  RestService restService = Modular.get<RestService>();
  GameService gameService = Modular.get<GameService>();
  RestService2 restService2 = Modular.get<RestService2>();
  GameModel? game;
  BuildContext? initializeContext;
  bool starting = false;
  bool terminating = false;
  InitializeState initializeState = InitializeState();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadGameStatus,
      child: ListView(
        padding: const EdgeInsets.only(top: 40),
        children: [
          Center(child: Text('${game?.title}')),
          const SizedBox(height: 32),
          if (game?.bgImage != null)
            Column(
              children: [
                Image(image: NetworkImage(game?.bgImage ?? '')),
                const SizedBox(height: 32),
              ],
            ),
          Observer(
            builder: (_) {
              String action = _getAction(gameService.gameStatus);
              return Column(
                children: [
                  OutlinedButton(
                    onPressed: starting || game == null ? null : _startgame,
                    child: Text(action),
                  ),
                  if (action == 'Resume') const SizedBox(height: 32),
                  if (action == 'Resume')
                    OutlinedButton(
                      onPressed: terminating
                          ? null
                          : () => _terminateSession(
                              gameService.gameStatus.sessionId!),
                      child: Text(terminating ? 'Terminating...' : 'Terminate'),
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _getGameById();
    super.initState();
  }

  void _getGameById() async {
    var game = await restService.getGameDetails(widget.id);

    setState(() => this.game = game);
  }

  String _getAction(GameStatusModel? gameStatus) {
    if (gameStatus != null && game != null) {
      if (gameStatus.gameId == game?.oneplayId) {
        if (gameStatus.isRunning == true) {
          return 'Resume';
        }
        return 'Play';
      }
      return 'Play';
    }
    return 'Play';
  }

  Future<void> _reloadGameStatus() async {
    var status = await restService2.getGameStatus();
    gameService.loadStatus(status);
  }

  void _startLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        initializeContext = context;
        return AlertDialog(
          title: Observer(builder: (_) => Text(initializeState.message)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Please wait while we connect you to the game'),
              SizedBox(height: 32),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
    setState(() {
      starting = true;
    });
  }

  void _stopLoading() {
    if (initializeContext != null) {
      Navigator.of(initializeContext!).pop();
      initializeContext = null;
    }

    setState(() {
      starting = false;
      initializeState.reset();
    });
  }

  void _showError({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _startgame() async {
    try {
      _startLoading();

      StartGameResponse res =
          await restService2.startGame(game?.oneplayId ?? '');

      if (res.data.apiAction == ApiAction.callSession) {
        _startGameWithClientToken(res.data.session?.id ?? '');
      } else if (res.data.apiAction == ApiAction.callTerminate) {
        _terminateGame(res.data.session?.id ?? '');
      } else {
        _stopLoading();
        _showError(
          title: 'Opps...',
          message: res.msg != '' ? res.msg : 'Something went wrong',
        );
      }
    } on DioError catch (e) {
      _stopLoading();
      _showError(title: 'Error', message: e.error['message']);
    }
  }

  void _startGameWithClientToken(String sessionId, {int millis = 0}) async {
    if (millis > 60000) {
      _stopLoading();
      _showError(title: 'Opps...', message: 'Something went wrong');
      return;
    }

    int startTime = DateTime.now().millisecondsSinceEpoch;

    try {
      ClientTokenModel data = await restService2.getClientToken(sessionId);

      if (data.token != '') {
        await _reloadGameStatus();
        _stopLoading();
        _launchGame(data.token);
      } else {
        initializeState.setMessage(data.msg);
        int timeTaken = DateTime.now().millisecondsSinceEpoch - startTime;
        if (timeTaken >= 2000) {
          _startGameWithClientToken(sessionId, millis: timeTaken + millis);
        } else {
          await Future.delayed(const Duration(seconds: 1));
          _startGameWithClientToken(
            sessionId,
            millis: timeTaken + millis + 1000,
          );
        }
      }
    } on DioError catch (e) {
      _stopLoading();
      _showError(title: 'Error', message: e.error['message']);
      return;
    }
  }

  void _terminateGame(String sessionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'You are already playing a game. Do you want to terminate it?',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await restService2.terminateSession(sessionId);
                _reloadGameStatus();
                _stopLoading();
                _startgame();
              } on DioError catch (e) {
                _stopLoading();
                _showError(title: 'Opps...', message: e.error['message']);
              }
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _stopLoading();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void _terminateSession(String sessionId) async {
    setState(() => terminating = true);
    try {
      await restService2.terminateSession(sessionId);
      await _reloadGameStatus();
      _showError(title: 'Success', message: 'Session Terminated');
    } on DioError catch (e) {
      _showError(title: 'Opps..', message: e.error['message']);
    } finally {
      setState(() => terminating = false);
    }
  }

  void _launchGame(String token) {
    MethodChannel channel = const MethodChannel('flutter-gui');
    channel.invokeMethod("startGame", token);
  }
}
