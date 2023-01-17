import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';

import '../common.dart';

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
