import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/common/utils/play_constant.dart';
import 'package:oneplay_flutter_gui/app/models/client_token_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_setting.dart';
import 'package:oneplay_flutter_gui/app/models/game_status_model.dart';
import 'package:oneplay_flutter_gui/app/models/start_game_model.dart';
import 'package:oneplay_flutter_gui/app/models/video_model.dart';
import 'package:oneplay_flutter_gui/app/pages/game/popup_game_setting.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/initialize_state.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/fake_focus.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/common.dart';
import '../../models/game_feed_model.dart';
import '../../widgets/list_game_w_label/list_game_w_label.dart';
import 'component.dart';

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
  AuthService authService = Modular.get<AuthService>();
  GameModel? game;
  List<ShortGameModel> devGames = [];
  List<ShortGameModel> genreGames = [];
  List<VideoModel> videos = [];
  BuildContext? initializeContext;
  bool starting = false;
  bool terminating = false;
  InitializeState initializeState = InitializeState();
  late SharedPreferences pref;

  int maxLoadTopVideo = 2;

  bool isShowSetting = true;
  bool wishlistLoading = false;
  GameSetting gameSetting = GameSetting();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadGameStatus,
      child: starting
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Stack(
                  children: [
                    ...bannerWidget(context, game!),
                    Observer(builder: (_) {
                      bool isInWishlist =
                          authService.wishlist.contains(game?.oneplayId);
                      return wishlistButton(
                        isInWishlist ? Icons.remove : Icons.add_rounded,
                        onTap: wishlistLoading
                            ? null
                            : () => _wishlistAction(isInWishlist),
                      );
                    }),
                    statusActionBtn()
                  ],
                ),
                checkShowSettingWidget(),
                commonDividerWidget(),
                FakeFocus(child: detailGameWidget(context, game)),
                FakeFocus(child: listTagWidget(context, game)),
                const SizedBox(
                  height: 10,
                ),
                commonDividerWidget(),
                topVideoLiveStreamsWidget(context, videos),
                commonDividerWidget(),
                const SizedBox(height: 30),
                if (genreGames.isNotEmpty)
                  listGameWithLabel(
                      GameFeedModel(title: 'From Genre', games: genreGames),
                      context),
                if (devGames.isNotEmpty)
                  listGameWithLabel(
                      GameFeedModel(title: 'From Developer', games: devGames),
                      context),

                // Center(child: Text('${game?.title}')),
                // const SizedBox(height: 32),
                // if (game?.bgImage != null)
                //   Column(
                //     children: [
                //       Image(image: NetworkImage(game?.bgImage ?? '')),
                //       const SizedBox(height: 32),
                //     ],
                //   ),
                // Observer(
                //   builder: (_) {
                //     String action = _getAction(gameService.gameStatus);
                //     return Column(
                //       children: [
                //         OutlinedButton(
                //           onPressed: starting || game == null ? null : _startgame,
                //           child: Text(action),
                //         ),
                //         if (action == 'Resume') const SizedBox(height: 32),
                //         if (action == 'Resume')
                //           OutlinedButton(
                //             onPressed: terminating
                //                 ? null
                //                 : () => _terminateSession(
                //                     gameService.gameStatus.sessionId!),
                //             child: Text(terminating ? 'Terminating...' : 'Terminate'),
                //           ),
                //       ],
                //     );
                //   },
                // )
              ],
            ),
    );
  }

  Container checkShowSettingWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: textPrimaryColor,
            ),
            child: Checkbox(
              value: isShowSetting,
              activeColor: textPrimaryColor,
              checkColor: Colors.black,
              onChanged: (value) => setState(() {
                isShowSetting = value!;
              }),
            ),
          ),
          Text(
            'Show settings before launch',
            style: tinyStyle.copyWith(color: textSecondaryColor),
          )
        ],
      ),
    );
  }

  Widget statusActionBtn() {
    return Container(
      height: 244,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20),
      child: Observer(builder: (_) {
        String action = _getAction(gameService.gameStatus);
        if (action == "Resume") {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FocusZoom(builder: (focus) {
                return InkWell(
                  focusNode: focus,
                  onTap: starting || game == null ? null : _startgame,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.white),
                    child: Center(
                        child: Text(
                      action,
                      style: const TextStyle(
                          color: basicLineColor,
                          fontFamily: mainFontFamily,
                          fontSize: 16,
                          letterSpacing: 0.02,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                );
              }),
              const SizedBox(height: 20),
              FocusZoom(builder: (focus) {
                return InkWell(
                  focusNode: focus,
                  onTap: terminating
                      ? null
                      : () =>
                          _terminateSession(gameService.gameStatus.sessionId!),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        gradient: const LinearGradient(
                          colors: [pinkColor2, purpleColor3],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                    child: Center(
                        child: Text(
                      terminating ? 'Terminating...' : 'Terminate',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: mainFontFamily,
                          fontSize: 16,
                          letterSpacing: 0.02,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                );
              })
            ],
          );
        }
        return Align(
          alignment: const Alignment(0, 1.2),
          child: FocusZoom(builder: (focus) {
            return InkWell(
              focusNode: focus,
              onTap: starting || game == null ? null : _startgame,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    gradient: const LinearGradient(
                      colors: [pinkColor1, blueColor1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Center(
                    child: Text(
                  action,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: mainFontFamily,
                      fontSize: 16,
                      letterSpacing: 0.02,
                      fontWeight: FontWeight.w500),
                )),
              ),
            );
          }),
        );
      }),
    );
  }

  void _addToWishlist() async {
    setState(() => wishlistLoading = true);
    try {
      await restService.addToWishlist(game?.oneplayId ?? "");
      setState(() => wishlistLoading = false);
      authService.addToWishlist(game?.oneplayId ?? "");
      _showSnackBar('Added to Library');
    } on DioError catch (e) {
      _showError(title: 'Error', message: e.error['message']);
    }
  }

  void _removeFromWishlist() async {
    setState(() => wishlistLoading = true);
    try {
      await restService.removeFromWishlist(game?.oneplayId ?? "");
      setState(() => wishlistLoading = false);
      authService.removeFromWishlist(game?.oneplayId ?? "");
      _showSnackBar('Removed from Library');
    } on DioError catch (e) {
      _showError(title: 'Error', message: e.error['message']);
    }
  }

  void _wishlistAction(bool isInWishlist) {
    if (isInWishlist) {
      _removeFromWishlist();
    } else {
      _addToWishlist();
    }
  }

  void _showSnackBar(String text) {
    final snackBar = ScaffoldMessenger.of(context);
    snackBar.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Done',
          onPressed: snackBar.hideCurrentSnackBar,
        ),
      ),
    );
  }

  @override
  void initState() {
    starting = true;
    init();
    super.initState();
  }

  init() async {
    pref = await SharedPreferences.getInstance();
    _getCurrGameSetting();
    var game = await restService.getGameDetails(widget.id);

    this.game = game;
    setState(() => starting = false);

    _getTopVideoById();
    _getFromGenreBydId();
    _getFromDeveloperBydId();
  }

  void _getFromGenreBydId() async {
    game?.genreMappings.forEach((element) async {
      var genreGames = await restService.getGamesByGenre(element);
      setState(() => this.genreGames =
          getShuffledGames([...this.genreGames, ...genreGames]));
    });
  }

  void _getFromDeveloperBydId() async {
    game?.developer.forEach((element) async {
      var devGames = await restService.getGamesByDeveloper(element);
      setState(() =>
          this.devGames = getShuffledGames([...this.devGames, ...devGames]));
    });
  }

  void _getTopVideoById() async {
    var videos = await restService.getVideos(widget.id);
    setState(() => this.videos = videos);
  }

  getShuffledGames(List<ShortGameModel> games) {
    return [...games];
  }

  void _getCurrGameSetting() {
    String subscribedPlan = authService.user?.subscribedPlan ?? "Founder";

    if (pref.getString("resolution") == null) {
      gameSetting.resolution =
          PlayConstants.DEFAULT_RESOLUTIONS[subscribedPlan]!;
    } else {
      gameSetting.resolution = pref.getString("resolution")!;
    }

    if (pref.getBool("is_vsync_enabled") == null) {
      gameSetting.is_vsync_enabled = true;
    } else {
      gameSetting.is_vsync_enabled = pref.getBool("is_vsync_enabled")!;
    }

    if (pref.getInt("fps") == null) {
      gameSetting.fps = PlayConstants.DEFAULT_FPS;
    } else {
      gameSetting.fps = pref.getInt("fps")!;
    }

    if (pref.getDouble("bitrate") == null) {
      gameSetting.bitrate = PlayConstants.getIdleBitrate(
          resolution: gameSetting.resolution!, fps: gameSetting.fps!);
    } else {
      gameSetting.bitrate = pref.getDouble("bitrate");
    }

    if (pref.getBool("fullscreen") == null) {
      gameSetting.fullscreen = true;
    } else {
      gameSetting.fullscreen = pref.getBool("fullscreen")!;
    }

    if (pref.getBool("onscreen_controls") == null) {
      gameSetting.onscreen_controls = false;
    } else {
      gameSetting.onscreen_controls = pref.getBool("onscreen_controls")!;
    }

    if (pref.getString("audio_type") == null) {
      gameSetting.audio_type = "stereo";
    } else {
      gameSetting.audio_type = pref.getString("audio_type")!;
    }
    if (pref.getString("stream_codec") == null) {
      gameSetting.stream_codec = "auto";
    } else {
      gameSetting.stream_codec = pref.getString("stream_codec")!;
    }
    if (pref.getBool("show_stats") == null) {
      gameSetting.show_stats = false;
    } else {
      gameSetting.show_stats = pref.getBool("show_stats")!;
    }

    if (pref.getString("video_decoder_selection") == null) {
      gameSetting.video_decoder_selection = "auto";
    } else {
      gameSetting.video_decoder_selection =
          pref.getString("video_decoder_selection")!;
    }
  }

  String _getAction(GameStatusModel? gameStatus) {
    if (gameStatus != null && game != null) {
      if (gameStatus.gameId == game?.oneplayId) {
        if (gameStatus.isRunning == true) {
          return 'Resume';
        }
        return 'Play Now';
      }
      return 'Play Now';
    }
    return 'Play Now';
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
          FocusZoom(builder: (focus) {
            return TextButton(
              focusNode: focus,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            );
          }),
        ],
      ),
    );
  }

  void _startgame() async {
    if (isShowSetting) {
      await showDialog(
        context: context,
        builder: (_) => gameSettingPopup(_, gameSetting, _startSession),
        barrierDismissible: false,
      );
    } else {
      _startSession();
    }
  }

  void _startSession() async {
    try {
      _startLoading();

      StartGameResponse res =
          await restService2.startGame(game?.oneplayId ?? '', gameSetting);

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
          FocusZoom(builder: (focus) {
            return TextButton(
              focusNode: focus,
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
            );
          }),
          FocusZoom(builder: (focus) {
            return TextButton(
              focusNode: focus,
              onPressed: () {
                Navigator.of(context).pop();
                _stopLoading();
              },
              child: const Text('No'),
            );
          }),
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
