import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../common/common.dart';

class SubscriptionHistoryTile extends StatelessWidget {
  const SubscriptionHistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '12.10.2022',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textPrimaryColor,
                fontSize: 14,
              ),
            ),
            Text(
              'Starter Edition.\$8.55',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor,
                fontSize: 14,
              ),
            ),
            GradientText(
              'Current',
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                decorationThickness: 1,
              ),
              gradientType: GradientType.linear,
              gradientDirection: GradientDirection.ltr,
              colors: const [purpleColor2, purpleColor1],
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        const Divider(
          color: basicLineColor,
          thickness: 0.6,
        ),
      ],
    );
  }
}
