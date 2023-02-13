import 'package:flutter/material.dart';

import '../../common/common.dart';

class SubmitButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String buttonTitle;
  final String loadingTitle;
  final bool isLoading;
  final Function()? onTap;

  const SubmitButton({
    super.key,
    this.height,
    this.width,
    this.buttonTitle = '',
    this.loadingTitle = '',
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double buttonHeight = height ?? size.height * 0.061;
    double buttonWidth = width ?? size.width;

    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
            colors: [pinkColor1, blueColor1],
          ),
        ),
        child: Center(
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      loadingTitle,
                      style: const TextStyle(
                        fontFamily: mainFontFamily,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.02,
                      ),
                    )
                  ],
                )
              : Text(
                  buttonTitle,
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.02,
                  ),
                ),
        ),
      ),
    );
  }
}
