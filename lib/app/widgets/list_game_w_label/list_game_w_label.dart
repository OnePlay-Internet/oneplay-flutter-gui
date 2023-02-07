import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import '../../common/common.dart';

Widget listGameWithLabel(GameFeedModel value) {
  return Container(
    height: 167.59,
    margin: const EdgeInsets.only(left: 20, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [titleLabelGames(value), listGames(value)],
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
      color: Colors.white,
    ),
  );
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
                    BlendMode.srcOver,
                  ),
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
                                    fontFamily: mainFontFamily,
                                  ),
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
