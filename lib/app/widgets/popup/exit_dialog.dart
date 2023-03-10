import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class ExitDialog extends StatelessWidget {
  final String title;
  final Function()? onYes;
  final Function()? onNo;
  final bool isLoading;

  const ExitDialog({
    super.key,
    required this.title,
    this.onYes,
    this.onNo,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: mainColor,
      contentPadding: const EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.all(
        size.width * 0.05,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Image.asset(
              logoutPng,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.05,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.05,
              ),
              child: SubmitButton(
                buttonTitle: 'Yes',
                loadingTitle: 'Logging out...',
                height: size.height * 0.056,
                width: size.width * 0.52,
                borderRadius: 25,
                fontSize: 15,
                isLoading: isLoading,
                onTap: onYes,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: size.height * 0.05,
              ),
              child: SubmitButton(
                buttonTitle: 'No',
                color: blackColor4,
                height: size.height * 0.056,
                width: size.width * 0.52,
                borderRadius: 25,
                fontSize: 15,
                onTap: onNo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
