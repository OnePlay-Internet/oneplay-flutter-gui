// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/Submit_Button/submit_button.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import '../services/shared_pref_service.dart';
import '../widgets/Responsive_Widget/responsive_widget.dart';
import '../widgets/list_game_w_label/game_list_tile.dart';
import '../widgets/popup/game_alert_dialog.dart';
import '../widgets/popup/steps_alert_dialog.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool logginOut = false;
  AuthService authService = Modular.get<AuthService>();
  RestService restService = Modular.get<RestService>();

  late GameFeedModel firstRow;
  late List<GameFeedModel> restRow;
  List<ShortGameModel> gameLibrary = [];

  bool starting = false;
  bool isDiolog = false;
  bool? getIsAgree;

  double? viewportFraction;
  double? height;

  _getHomeFeed() async {
    setState(() => starting = true);
    try {
      await restService.getHomeFeed().then((value) async {
        firstRow = value[0];
        restRow = value.getRange(1, value.length).toList();
        if (mounted) setState(() => starting = false);
      });
    } on DioError catch (e) {
      ErrorHandler.networkErrorHandler(e, context);
    }
  }

  Future<List<ShortGameModel>> _getLibrary() async {
    try {
      gameLibrary = await restService.getWishlistGames(authService.wishlist);

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (gameLibrary.isEmpty) {
          _showGameDialog();
        }
      });

      return gameLibrary;
    } catch (e) {
      return [];
    }
  }

  _showGameDialog() {
    if (isDiolog == true) {
    } else {
      isDiolog = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const GameAlertDialog();
        },
      );
    }
  }

  @override
  void initState() {
    _getHomeFeed();
    getIsAgree = SharedPrefService.getIsAgree();
    Future.delayed(Duration.zero, () => _popAgreeDialog());
    super.initState();
  }

  _popAgreeDialog() {
    print("***** isAgree: $getIsAgree *****");

    if (getIsAgree == false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertStepsPopUp(
            onTap: () {
              SharedPrefService.storeUserId([
                AuthService().userIdToken!.userId,
              ]);

              SharedPrefService.storeIsAgree(true);

              Navigator.pop(_);
            },
          );
        },
      );
    }
  }

  logout() async {
    AuthService authService = Modular.get<AuthService>();
    setState(() => logginOut = true);
    await authService.logout();
    setState(() => logginOut = false);
    Modular.to.navigate('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 8;

        height = Responsive.isTablet(context)
            ? size.height * 0.3
            : isPortrait == 8 || isPortrait == 8
                ? size.height * 0.67
                : size.height * 0.23;
        viewportFraction = Responsive.isTablet(context)
            ? 0.77
            : isPortrait == 8 || isPortrait == 8
                ? 0.58
                : 0.7;

        return GamepadPop(
          context: context,
          child: starting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: ListView(
                      children: [
                        bannerWidget(firstRow, size, isPortrait),
                        Observer(
                          builder: (context) {
                            return FutureBuilder(
                              future: _getLibrary(),
                              builder: (_, snap) {
                                return snap.hasData
                                    ? snap.data!.isNotEmpty
                                        ? GameListTile(
                                            isPortrait: isPortrait,
                                            gameFeed: GameFeedModel(
                                              title: 'My Library',
                                              games: snap.data!,
                                            ),
                                          )
                                        : Container()
                                    : Container();
                              },
                            );
                          },
                        ),
                        ...restRow.map(
                          (value) {
                            return GameListTile(
                              isPortrait: isPortrait,
                              gameFeed: value,
                            );
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
    // return Container(
    //   padding: const EdgeInsets.all(4),
    //   alignment: Alignment.center,
    //   child: Column(
    //     children: [
    //       Observer(builder: (_) {
    //         return Text('Hi ${authService.user?.firstName}');
    //       }),
    //       const SizedBox(height: 24),
    //       OutlinedButton(
    //         onPressed: logginOut ? null : logout,
    //         child: const Text('Logout'),
    //       ),
    //     ],
    //   ),
    // );
  }

  CarouselSlider bannerWidget(
    GameFeedModel data,
    Size size,
    int isPortrait,
  ) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: viewportFraction!,
        height: height,
      ),
      items: data.games.map(
        (item) {
          return item.textBgImage!.isNotEmpty
              ? FocusZoom(
                  builder: (focusNode) {
                    return Stack(
                      children: [
                        InkWell(
                          focusNode: focusNode,
                          onTap: (() =>
                              Modular.to.pushNamed('/game/${item.oneplayId}')),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: item.textBgImage.toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        isPortrait == 8
                            ? Positioned(
                                bottom: size.height * 0.12,
                                left: size.width * 0.05,
                                child: SubmitButton(
                                  buttonTitle: 'Play Now',
                                  height: size.height * 0.1,
                                  width: size.width * 0.16,
                                  borderRadius: 25,
                                  fontSize: 18,
                                  onTap: () {
                                    Modular.to
                                        .pushNamed('/game/${item.oneplayId}');
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                )
              : const SizedBox.shrink();
        },
      ).toList(),
    );
  }
}
