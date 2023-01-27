import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

authFooterWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        '© 2022 RainBox Media Pvt Ltd.',
        style: TextStyle(
            fontFamily: mainFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: whiteColor1),
      ),
      const Text(
        'All Rights Reserved.',
        style: TextStyle(
            fontFamily: mainFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: whiteColor1),
      ),
      GradientText(
        'Privacy Policy . Terms & Conditions',
        style: const TextStyle(
          fontFamily: mainFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.02,
          decoration: TextDecoration.underline,
        ),
        gradientType: GradientType.linear,
        gradientDirection: GradientDirection.ltr,
        colors: const [purpleColor2, purpleColor1],
      ),
      const SizedBox(height: 30)
    ],
  );
}

Padding needHelpWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Need help? ',
          style: TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
              color: textSecondaryColor),
        ),
        GradientText(
          'Browse FAQ',
          style: const TextStyle(
            fontFamily: mainFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            decorationThickness: 1,
            decoration: TextDecoration.underline,
          ),
          gradientType: GradientType.linear,
          gradientDirection: GradientDirection.ltr,
          colors: const [purpleColor2, purpleColor1],
        ),
      ]),
    );
  }