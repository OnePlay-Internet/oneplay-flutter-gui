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
  bool starting = false;
  List<GameModel> library = [];
  List<String> wishlist = [];

  _getHomeFeed() async {
    setState(() => starting = true);
    await restService.getHomeFeed().then((value) async {
      firstRow = value[0];
      restRow = value.getRange(2, value.length).toList();
      setState(() => starting = false);
    });
  }

  @override
  void initState() {
    _getHomeFeed();
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
                  ...restRow
                      .map((value) => Container(
                          height: 167.59,
                          margin: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleLabelGames(value),
                              listGames(value)
                            ],
                          )))
                      .toList()
                ],
              ),
            )),
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

  SizedBox listGames(GameFeedModel value) {
    return SizedBox(
      height: 127.59,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: value.games
            .map((e) => InkWell(
                  onTap: (() => Modular.to.pushNamed('/game/${e.oneplayId}')),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        e.status == "live"
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.5),
                        BlendMode.srcOver),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      height: 127.59,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: e.textBgImage.toString(),
                          fit: BoxFit.fitHeight,
                          height: 127.59,
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
                                    e.title.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: mainFontFamily),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Text titleLabelGames(GameFeedModel value) {
    return Text(
      value.title,
      style: const TextStyle(
          fontFamily: mainFontFamily,
          fontSize: 18,
          letterSpacing: 0.02,
          fontWeight: FontWeight.w500,
          color: Colors.white),
    );
  }

  CarouselSlider bannerWidget(GameFeedModel data) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.75,
      ),
      items: data.games.map((item) {
        return item.textBgImage!.isNotEmpty
            ? InkWell(
                onTap: (() => Modular.to.pushNamed('/game/${item.oneplayId}')),
                child: Container(
                  height: 200,
                  width: 300,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: item.textBgImage.toString(),
                        height: 200,
                        width: 300,
                        fit: BoxFit.fitHeight,
                      )),
                ),
              )
            : const SizedBox.shrink();
      }).toList(),
    );
  }
}
