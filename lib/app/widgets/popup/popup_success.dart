import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';

AlertDialog alertSuccess({
  required BuildContext context,
  required String title,
  required String description,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
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
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
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
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
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
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
