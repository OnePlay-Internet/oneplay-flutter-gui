// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';

import '../../main.dart';
import '../widgets/list_game_w_label/list_game_w_label.dart';
import '../widgets/popup/game_alert_dialog.dart';

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
  List<ShortGameModel> library = [];
  bool starting = false;
  bool isDiolog = false;

  _getHomeFeed() async {
    setState(() => starting = true);
    await restService.getHomeFeed().then((value) async {
      firstRow = value[0];
      restRow = value.getRange(2, value.length).toList();
      if (mounted) setState(() => starting = false);
    });
  }

  _getLibrary() {
    restService.getWishlistGames(authService.wishlist).then((value) {
      if (mounted) setState(() => library = value);

      _showGameDialog();
    });
  }

  _showGameDialog() {
    if (library.isEmpty) {
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
  }

  @override
  void initState() {
    _getHomeFeed();
    // _getLibrary();

    super.initState();
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
    return Scaffold(
      backgroundColor: mainColor,
      body: starting
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    bannerWidget(firstRow),
                    Observer(builder: (context) {
                      _getLibrary();
                      return library.isNotEmpty
                          ? listGameWithLabel(
                              GameFeedModel(
                                  title: 'My Library', games: library),
                              context)
                          : Container();
                    }),
                    ...restRow
                        .map((value) => listGameWithLabel(value, context))
                        .toList()
                  ],
                ),
              ),
            ),
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

  CarouselSlider bannerWidget(GameFeedModel data) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.75,
      ),
      items: data.games.map((item) {
        return item.textBgImage!.isNotEmpty
            ? FocusZoom(builder: (focusNode) {
                return InkWell(
                  focusNode: focusNode,
                  onTap: (() =>
                      Modular.to.pushNamed('/game/${item.oneplayId}')),
                  child: Container(
                    height: 200,
                    width: 300,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: item.textBgImage.toString(),
                          height: 200,
                          width: 300,
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                );
              })
            : const SizedBox.shrink();
      }).toList(),
    );
  }
}
