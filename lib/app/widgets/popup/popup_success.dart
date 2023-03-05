import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';

AlertDialog alertSuccess({
  required BuildContext context,
  required String title,
  required String description,
}) {
  Size size = MediaQuery.of(context).size;

  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      height: size.height * 0.55,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            successPopupPng,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            description,
            maxLines: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: mainFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.02,
              color: textSecondaryColor,
            ),
          )
        ],
      ),
    ),
  );
}

AlertDialog alertError({
  required BuildContext context,
  required String title,
  required String description,
}) {
  Size size = MediaQuery.of(context).size;

  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      height: size.height * 0.55,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            errorPopupPng,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              description,
              maxLines: 4,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
