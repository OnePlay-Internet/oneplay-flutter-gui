import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';

InkWell gameRow(ShortGameModel e) {
  return InkWell(
    onTap: (() => Modular.to.pushNamed('/game/${e.oneplayId}')),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: e.bgImage.toString(),
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
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: const TextStyle(
                    color: textPrimaryColor,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  e.releaseDate.year.toString(),
                  style: const TextStyle(
                    color: textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
