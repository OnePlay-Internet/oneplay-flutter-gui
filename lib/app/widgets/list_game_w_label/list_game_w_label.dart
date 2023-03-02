import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import '../../common/common.dart';

Widget listGameWithLabel(GameFeedModel value, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 1 / 5.5,
    margin: const EdgeInsets.only(left: 20, bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleLabelGames(value),
        const SizedBox(
          height: 17,
        ),
        listGames(value, context),
      ],
    ),
  );
}

Text titleLabelGames(GameFeedModel value) {
  return Text(
    value.title,
    style: const TextStyle(
      fontFamily: mainFontFamily,
      fontSize: 15,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w500,
      color: textPrimaryColor,
    ),
  );
}

SizedBox listGames(GameFeedModel value, BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 1 / 7.8,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: value.games
          .map(
            (e) => FocusZoom(
              builder: (focusNode) {
                return InkWell(
                  focusNode: focusNode,
                  onTap: (() => Modular.to.pushNamed('/game/${e.oneplayId}')),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 20),
                    height: MediaQuery.of(context).size.height * 1 / 7.4,
                    width: MediaQuery.of(context).size.width * 2.3 / 4.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          e.status == "live"
                              ? Colors.transparent
                              : Colors.grey.withOpacity(0.5),
                          BlendMode.srcOver,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: e.textBgImage.toString(),
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 1 / 7.4,
                          width: MediaQuery.of(context).size.width * 2.3 / 4.5,
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
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width *
                                      2.3 /
                                      4.5,
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
                );
              },
            ),
          )
          .toList(),
    ),
  );
}
