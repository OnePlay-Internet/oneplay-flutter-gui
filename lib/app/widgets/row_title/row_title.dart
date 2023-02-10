import 'package:flutter/material.dart';

import '../../common/common.dart';

class RowTitle extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;

  const RowTitle({
    super.key,
    this.title1 = 'Title1',
    this.title2 = 'Title2',
    this.title3 = 'Title3',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title1,
          style: const TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: textSecondaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          title2,
          style: const TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: textSecondaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          title3,
          style: const TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: textSecondaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
