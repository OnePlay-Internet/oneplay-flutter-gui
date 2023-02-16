import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/common.dart';

Future<bool> showExitBottomSheet(context) async {
  return await showModalBottomSheet(
    backgroundColor: basicLineColor,
    context: context,
    builder: (context) {
      return ConfirmationBottomsheetCard(
        title: "Do you want to exit?",
        pressNo: () {
          Navigator.of(context).pop();
        },
        pressYes: () {
          exit(0);
        },
      );
    },
  );
}

class ConfirmationBottomsheetCard extends StatelessWidget {
  final String title;
  final Function()? pressYes;
  final Function()? pressNo;

  const ConfirmationBottomsheetCard({
    Key? key,
    this.title = 'Are you sure to logout?',
    this.pressYes,
    this.pressNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: pressNo,
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      color: textSecondaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontFamily: 'nexa',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: pressYes,
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      color: textSecondaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontFamily: 'nexa',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
