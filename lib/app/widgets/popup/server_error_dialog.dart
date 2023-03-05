import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class AlertServerErrorDialog extends StatelessWidget {
  final String errorMessage;

  const AlertServerErrorDialog({
    super.key,
    required this.errorMessage,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05,
                ),
                child: const Text(
                  'Server Error',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.02,
                    color: textPrimaryColor,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05,
                ),
                child: Image.asset(
                  serverErrorPng,
                ),
              ),
              SubmitButton(
                buttonTitle: 'Ok',
                width: size.width * 0.6,
                borderRadius: 25,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
