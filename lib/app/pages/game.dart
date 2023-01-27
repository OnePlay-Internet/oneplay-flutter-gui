import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:oneplay_flutter_gui/app/models/video_model.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/initialize_state.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:readmore/readmore.dart';

import '../common/common.dart';
import '../models/game_feed_model.dart';
import '../widgets/list_game_w_label/list_game_w_label.dart';

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
  List<ShortGameModel> devGames = [];
  List<ShortGameModel> genreGames = [];
  List<VideoModel> videos = [];
  BuildContext? initializeContext;
  bool starting = false;
  bool terminating = false;
  InitializeState initializeState = InitializeState();

  int maxLoadTopVideo = 2;

  bool isShowSetting = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadGameStatus,
      child: ListView(
        children: [
          if (game?.bgImage != null) bannerImageWidget(context),
          checkShowSettingWidget(context),
          commonDividerWidget(),
          detailGameWidget(),
          listTagWidget(),
          const SizedBox(
            height: 10,
          ),
          commonDividerWidget(),
          topVideoLiveStreamsWidget(),
          commonDividerWidget(),
          const SizedBox(height: 30),
          if (genreGames.isNotEmpty)
            listGameWithLabel(
                GameFeedModel(title: 'From Genre', games: genreGames)),
          if (genreGames.isNotEmpty)
            listGameWithLabel(
                GameFeedModel(title: 'From Developer', games: devGames)),

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

  Widget topVideoLiveStreamsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Top Live Streams',
              style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor),
            ),
          ),
          const SizedBox(height: 15),
          ...videos.map((e) {
            if (videos.indexOf(e) < maxLoadTopVideo) return videoWidget(e);
            return const SizedBox.shrink();
          }).toList(),
          if (maxLoadTopVideo < videos.length)
            InkWell(
              onTap: (() {
                setState(() => maxLoadTopVideo += 3);
              }),
              child: Container(
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    end: Alignment.centerLeft,
                    begin: Alignment.centerRight,
                    colors: [blackColor1, blackColor2],
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Center(
                  child: Text(
                    'Browse more streams',
                    style: TextStyle(
                        fontFamily: mainFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.02,
                        color: Colors.white),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget videoWidget(VideoModel video) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 370,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 248,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: video.thumbnail,
                  width: 125,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      defaultBg,
                      fit: BoxFit.fitHeight,
                    );
                  },
                ),
              ),
            ),
            Text(video.title,
                style: tinyStyle.copyWith(color: textSecondaryColor),
                maxLines: 2),
            SizedBox(
              height: 52,
              child: Row(children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CachedNetworkImage(
                      imageUrl: video.creatorThumbnail,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.creatorName,
                        style: tinyStyle.copyWith(color: textSecondaryColor)),
                    Text(video.updatedAt.toString(),
                        style: tinyStyle.copyWith(color: textSecondaryColor)),
                  ],
                )
              ]),
            ),
          ]),
    );
  }

  Widget listTagWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Tags',
              style: tinyStyle.copyWith(color: textSecondaryColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children:
                game?.genreMappings.map((e) => tagWidget(e)).toList() ?? [],
          )
        ],
      ),
    );
  }

  Widget tagWidget(String? tagName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      height: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [purpleColor2, purpleColor1],
          )),
      child: Text(
        tagName ?? '',
        style: const TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.02,
            color: Colors.white),
      ),
    );
  }

  Widget detailGameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Game',
            style: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
                color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ReadMoreText(
              game?.description ?? "",
              style: tinyStyle.copyWith(color: textSecondaryColor),
              trimMode: TrimMode.Line,
              trimLines: 3,
              colorClickableText: textPrimaryColor,
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Collapse',
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store',
                      style: tinyStyle.copyWith(color: textSecondaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (game != null)
                      if (game!.storesMapping.isNotEmpty)
                        Row(
                          children: [
                            // CachedNetworkImage(
                            //     imageUrl: game?.storesMapping[0].link ?? "",
                            //     height: 30),
                            // const SizedBox(height: 20),
                            Text(game?.storesMapping[0].name ?? "",
                                style: tinyStyle)
                          ],
                        )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Developer',
                        style: tinyStyle.copyWith(color: textSecondaryColor)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      game?.developer
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(',', '') ??
                          "",
                      style: tinyStyle,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container checkShowSettingWidget(BuildContext context) {
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

  Stack bannerImageWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 244,
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: game!.bgImage,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorWidget: (context, url, error) {
                return Stack(
                  children: [
                    Image.asset(
                      defaultBg,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      top: 40,
                      left: 5,
                      child: Text(
                        game!.title,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: mainFontFamily),
                        maxLines: 2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          height: 244,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(65),
                    Colors.black,
                  ],
                  stops: const [
                    0.0,
                    1.0
                  ])),
        ),
        Positioned(
            top: 40,
            right: 40,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90), color: Colors.black),
              child: Center(
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xff59FEF4),
                            Color(0xff3AA0FE),
                          ])),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
        Container(
          height: 244,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20),
          child: Align(
              alignment: const Alignment(0, 1.2),
              child: Observer(builder: (_) {
                String action = _getAction(gameService.gameStatus);
                return InkWell(
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
              })),
        )
      ],
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    var game = await restService.getGameDetails(widget.id);
    setState(() => this.game = game);

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

  // private getShuffledGames(games: GameModel[]): GameModel[] {
  //   return [...games].sort(() => Math.random() - 0.5);
  // }

  getShuffledGames(List<ShortGameModel> games) {
    return [...games];
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
