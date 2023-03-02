import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import '../../common/common.dart';

Widget getStoreContent(GameFeedModel value, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [titleLabelGames(value), listGames(value, context)],
  );
}

Container titleLabelGames(GameFeedModel value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      value.title,
      style: const TextStyle(
        fontFamily: mainFontFamily,
        fontSize: 16,
        letterSpacing: 0.02,
        fontWeight: FontWeight.w500,
        color: textPrimaryColor,
      ),
    ),
  );
}

Widget listGames(GameFeedModel value, BuildContext context) {
  return GridView.count(
    primary: false,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 25,
    mainAxisSpacing: 25,
    crossAxisCount: 2,
    childAspectRatio: 1.6,
    children: value.games
        .map((e) => FocusZoom(builder: (focusNode) {
              return InkWell(
                focusNode: focusNode,
                onTap: (() => Modular.to.pushNamed('/game/${e.oneplayId}')),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          e.status == "live"
                              ? Colors.transparent
                              : Colors.grey.withOpacity(0.5),
                          BlendMode.srcOver),
                      child: CachedNetworkImage(
                        imageUrl: e.textBgImage.toString(),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
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
                                width: double.infinity,
                                height: double.infinity,
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
              );
            }))
        .toList(),
  );
}
