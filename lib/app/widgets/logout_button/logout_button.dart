import 'package:flutter/material.dart';

import '../../common/common.dart';

class LogoutButton extends StatelessWidget {
  final String buttonTitle;
  final double? height;
  final double? width;
  final Function()? onTap;

  const LogoutButton({
    super.key,
    this.buttonTitle = '',
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double btnHeight = height ?? size.height * 0.05;
    double btnWidth = width ?? size.width * 0.42;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: basicLineColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: const TextStyle(
              fontFamily: mainFontFamily,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
              color: textPrimaryColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
