import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../common/common.dart';

class GradientTextButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final List<Color>? colors;

  const GradientTextButton({
    super.key,
    required this.title,
    this.onTap,
    this.padding,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: GradientText(
          title,
          style: const TextStyle(
            fontFamily: mainFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            decorationThickness: 1,
          ),
          gradientType: GradientType.linear,
          gradientDirection: GradientDirection.ltr,
          colors: colors != null ? colors! : [purpleColor2, purpleColor1],
        ),
      ),
    );
  }
}
