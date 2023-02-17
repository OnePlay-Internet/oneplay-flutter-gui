import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class FirstStep extends StatelessWidget {
  final Function()? onTap;

  const FirstStep({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        Image.asset(
          imgStep1,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        const Text(
          'Step 1',
          style: TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.02,
            color: textSecondaryColor,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        const Text(
          'You need to have 3rd party login in\norder to use OnePlay Services.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: textSecondaryColor,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        SubmitButton(
          buttonTitle: 'Next',
          color: basicLineColor,
          height: size.height * 0.056,
          width: size.width * 0.45,
          borderRadius: 25,
          fontSize: 14,
          onTap: onTap,
        ),
      ],
    );
  }
}
