import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/common.dart';
import '../../models/game_feed_model.dart';
import '../Responsive_Widget/responsive_widget.dart';
import '../focus_zoom/focus_zoom.dart';

class GameListTile extends StatelessWidget {
  final GameFeedModel gameFeed;
  final int isPortrait;

  const GameListTile({
    super.key,
    required this.gameFeed,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = isPortrait == 8 ? size.height * 0.3 : size.height * 0.123;
    var width = Responsive.isTablet(context)
        ? size.width * 0.4
        : isPortrait == 8 || isPortrait == 8
            ? size.width * 0.27
            : size.width * 0.46;

    return Container(
      margin: EdgeInsets.only(
        left: isPortrait == 8 ? size.width * 0.018 : size.width * 0.033,
        bottom: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gameFeed.title,
            style: const TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 15,
              letterSpacing: 0.02,
              fontWeight: FontWeight.w500,
              color: textPrimaryColor,
            ),
          ),
          SizedBox(
            // height: 17,
            height: size.height * 0.02,
          ),
          SizedBox(
            // height: MediaQuery.of(context).size.height * 1 / 8.2,
            height: height,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: gameFeed.games
                  .map(
                    (e) => FocusZoom(
                      builder: (focusNode) {
                        return InkWell(
                          focusNode: focusNode,
                          onTap: () {
                            Modular.to.pushNamed('/game/${e.oneplayId}');
                          },
                          child: Container(
                            width: width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              right: isPortrait == 8
                                  ? size.width * 0.026
                                  : size.width * 0.033,
                            ),
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
                                  height: size.height,
                                  width: size.width,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
          ),
        ],
      ),
    );
  }
}
