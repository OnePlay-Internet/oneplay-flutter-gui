import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../gamepad_pop/gamepad_pop.dart';
import 'error_report_dialog.dart';

class AlertErrorDialog extends StatelessWidget {
  final int? errorCode;
  final String error;
  final Function()? onTap1;
  final Future Function(String message)? onTap2;
  final bool starting;

  const AlertErrorDialog({
    super.key,
    required this.error,
    this.errorCode,
    this.onTap1,
    this.onTap2,
    this.starting = false,
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
                errorCode != null ? 'Error Code: $errorCode' : 'Oops...',
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.04),
                    child: SubmitButton(
                      buttonTitle: onTap1 == null ? 'Ok' : 'Try Again',
                      width: size.width * 0.6,
                      borderRadius: 25,
                      onTap: () {
                        Navigator.pop(context);
                        onTap1!();
                      },
                    ),
                  ),
                  if (onTap2 != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.04,
                      ),
                      child: SubmitButton(
                        color: blackColor4,
                        buttonTitle: 'Send Error Report',
                        width: size.width * 0.6,
                        borderRadius: 25,
                        onTap: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) => GamepadPop(
                              context: context,
                              child: AlertErrorReportDialog(
                                onTap: (String message) async {
                                  await onTap2!(message);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
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
