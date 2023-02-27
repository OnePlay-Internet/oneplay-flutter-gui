import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _launchURL('https://www.oneplay.in/privacy.html'),
            child: GradientText(
              'Privacy Policy',
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
          ),
          const Text(
            ' . ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: mainFontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
            ),
          ),
          GestureDetector(
            onTap: () => _launchURL('https://www.oneplay.in/tnc.html'),
            child: GradientText(
              'Terms & Conditions',
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
          ),
        ],
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}

Padding haveAccount({
  required String title,
  required String btnTitle,
  required void Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 40,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
              color: textSecondaryColor),
        ),
        InkWell(
          onTap: onTap,
          child: GradientText(
            btnTitle,
            style: const TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
            ),
            gradientType: GradientType.linear,
            gradientDirection: GradientDirection.ltr,
            colors: const [purpleColor2, purpleColor1],
          ),
        ),
      ],
    ),
  );
}

Padding needHelpWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Need help? ',
          style: TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
              color: textSecondaryColor),
        ),
        GestureDetector(
          onTap: () => _launchURL('https://www.oneplay.in/contact.html'),
          child: GradientText(
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
        ),
      ],
    ),
  );
}

bySigningUpFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 40,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          checkPng,
          width: 20,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'By singing up, you agree to OnePlay’s',
              textScaleFactor: 1.03,
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      _launchURL('https://www.oneplay.in/privacy.html'),
                  child: GradientText(
                    'Privacy Policy',
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
                ),
                const Text(
                  ' & ',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _launchURL('https://www.oneplay.in/tnc.html'),
                  child: GradientText(
                    'Terms and ',
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
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _launchURL('https://www.oneplay.in/tnc.html'),
              child: GradientText(
                'Conditions',
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
            ),
          ],
        ),
      ],
    ),
  );
}
