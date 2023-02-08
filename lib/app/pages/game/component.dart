import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:readmore/readmore.dart';

import '../../common/common.dart';
import '../../models/game_model.dart';
import '../../models/video_model.dart';

Widget topVideoLiveStreamsWidget(
    BuildContext context, List<VideoModel> videos) {
  int maxLoadTopVideo = 3;
  return StatefulBuilder(
    builder: (_, setState) {
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
              if (videos.indexOf(e) < maxLoadTopVideo)
                return videoWidget(context, e);
              return const SizedBox.shrink();
            }).toList(),
            if (maxLoadTopVideo < videos.length)
              FocusZoom(builder: (focus) {
                return InkWell(
                  focusNode: focus,
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
                );
              })
          ],
        ),
      );
    },
  );
}

Widget videoWidget(BuildContext context, VideoModel video) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    height: 370,
    child: FocusZoom(builder: (focus) {
      return InkWell(
        focusNode: focus,
        onTap: () {},
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
          ],
        ),
      );
    }),
  );
}

Widget listTagWidget(BuildContext context, GameModel? game) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          children: game?.genreMappings.map((e) => tagWidget(e)).toList() ?? [],
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

Widget detailGameWidget(BuildContext context, GameModel? game) {
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
                    if (game.storesMapping.isNotEmpty)
                      Row(
                        children: [
                          // CachedNetworkImage(
                          //     imageUrl: game?.storesMapping[0].link ?? "",
                          //     height: 30),
                          // const SizedBox(height: 20),
                          Text(
                            game.storesMapping[0].name,
                            style: tinyStyle,
                          )
                        ],
                      )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer',
                    style: tinyStyle.copyWith(color: textSecondaryColor),
                  ),
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
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

List<Widget> bannerWidget(BuildContext context, GameModel? game) {
  return [
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
                    game.title,
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
  ];
}

Widget wishlistButton(IconData iconData, {void Function()? onTap}) {
  return Positioned(
    top: 40,
    right: 40,
    child: FocusZoom(builder: (focus) {
      return InkWell(
        focusNode: focus,
        onTap: onTap,
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Colors.black,
          ),
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
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  iconData,
                  size: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }),
  );
}
