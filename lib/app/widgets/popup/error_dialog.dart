import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class AlertErrorDialog extends StatelessWidget {
  final String errorCode;
  final String error;
  final Function()? onTap1;
  final Function()? onTap2;

  const AlertErrorDialog({
    super.key,
    required this.errorCode,
    required this.error,
    this.onTap1,
    this.onTap2,
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
                child: Image.asset(
                  errorPopupPng,
                  height: 90,
                ),
              ),
              Text(
                'Error Code: $errorCode',
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.04,
                ),
                child: Text(
                  'Error: $error',
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
              onTap1 == null
                  ? Padding(
                      padding: EdgeInsets.only(
                        bottom: size.height * 0.04,
                      ),
                      child: SubmitButton(
                        buttonTitle: 'Ok',
                        width: size.width * 0.6,
                        borderRadius: 25,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  : Column(
                      children: [
                        SubmitButton(
                          buttonTitle: 'Try Again',
                          width: size.width * 0.6,
                          borderRadius: 25,
                          onTap: onTap1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.04,
                          ),
                          child: SubmitButton(
                            color: blackColor4,
                            buttonTitle: 'Send Error Report',
                            width: size.width * 0.6,
                            borderRadius: 25,
                            onTap: onTap2,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
