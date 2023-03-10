import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class AlertAskDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onTapYes;
  final Function()? onTapNo;

  const AlertAskDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTapYes,
    this.onTapNo,
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
            onTapNo != null
                ? Image.asset(
                    errorPopupPng,
                    height: 90,
                  )
                : Image.asset(
                    successPopupPng,
                    height: 90,
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
                top: size.height * 0.03,
              ),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: onTapNo != null ? 0.0 : size.height * 0.05,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: SubmitButton(
                buttonTitle: onTapNo != null ? 'Yes' : 'Ok',
                fontSize: 15,
                onTap: onTapYes,
              ),
            ),
            onTapNo != null
                ? Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      bottom: size.height * 0.05,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: SubmitButton(
                      buttonTitle: 'No',
                      color: blackColor4,
                      fontSize: 15,
                      onTap: onTapNo,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
