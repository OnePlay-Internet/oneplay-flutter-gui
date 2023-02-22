import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class AlertTermsAndCondition extends StatelessWidget {
  const AlertTermsAndCondition({
    super.key,
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
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [pinkColor1, blueColor1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.6),
          child: Container(
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.06,
                      ),
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: whiteColor1,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      'Offer is valid only when your \nfriend successfully signs up OnePlay platform using your referral link.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: mainFontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02,
                        color: textSecondaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.028,
                        horizontal: size.width * 0.3,
                      ),
                      child: const Divider(
                        height: 1,
                        color: basicLineColor,
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SubmitButton(
                      buttonTitle: 'Okay',
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
          ),
        ),
      ),
    );
  }
}
