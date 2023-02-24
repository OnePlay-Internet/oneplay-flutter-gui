// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/theme/color.dart';
import 'package:oneplay_flutter_gui/app/common/theme/pngPath.dart';

class AppBarWidget {
  Widget logoWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoPng, height: 37.52),
          const SizedBox(width: 11.9),
          Image.asset(betatagPng, height: 21.32)
        ],
      ),
    );
  }

  Widget menu(
    BuildContext context, {
    //   Function()? openDrawer,
    Function()? searchTap,
    Function()? profileTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: 18,
      ),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: basicLineColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // InkWell(
          //   // onTap: openDrawer,
          //   child: Container(
          //     padding: const EdgeInsets.all(10.0),
          //     margin: const EdgeInsets.only(left: 10.0),
          //     child: SvgPicture.asset(
          //       menuIcon,
          //       color: Colors.white,
          //       height: 18,
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: searchTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                color: blackColor1,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: const Icon(
                Icons.search,
                color: textPrimaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(logoPng, height: 31.52),
              const SizedBox(width: 10),
              Image.asset(betatagPng, height: 18)
            ],
          ),
          InkWell(
            onTap: profileTap,
            child: Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(right: 15.0),
              child: Image.asset(userPng),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(100),
              //   child: CachedNetworkImage(
              //     imageUrl:
              //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7KwDl1w4ReBuWUjLiEd6AQNSEHjnqF8VH7Aflhq179xxAEOyHw6pbgKJtCewBexVFshk&usqp=CAU',
              //   ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
