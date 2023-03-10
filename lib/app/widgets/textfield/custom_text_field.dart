import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../common/common.dart';

StatefulBuilder customTextField({
  required String labelText,
  required String hintText,
  required TextEditingController textCtrler,
  TextInputType textInputType = TextInputType.text,
  String errorText = '',
  Function(String text)? onChanged
}) {
  bool isHideText = textInputType == TextInputType.visiblePassword;
  bool onChangeText = false;
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        height: 84,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText,
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textPrimaryColor,
                    fontSize: 14,
                  ),
                ),
                errorText != ""
                    ? GradientText(
                        errorText,
                        style: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          decorationThickness: 1,
                        ),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ltr,
                        colors: const [pinkColor2, purpleColor3],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: 50,
              child: Stack(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontFamily: mainFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02,
                        color: textSecondaryColor,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: blackColor1,
                          width: 2,
                        ),
                      ),
                      suffixIcon: textInputType == TextInputType.visiblePassword
                          ? FocusZoom(
                              builder: (focus) {
                                return InkWell(
                                  // focusNode: focus,
                                  onTap: () {
                                    setState(() => isHideText = !isHideText);
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    alignment: Alignment.centerRight,
                                    child: SvgPicture.asset(
                                      isHideText ? hidePwdIcon : showPwdIcon,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    ),
                    controller: textCtrler,
                    keyboardType: textInputType,
                    obscureText: isHideText,
                    onTap: () => setState(() => onChangeText = true),
                    onEditingComplete: () {
                      setState(() => onChangeText = false);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: onChanged,
                    style: const TextStyle(
                      fontFamily: mainFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textSecondaryColor,
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    child: Container(
                      height: 3,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: errorText != ''
                              ? [pinkColor2, purpleColor3]
                              : onChangeText
                                  ? [textSecondaryColor, textSecondaryColor]
                                  : [blackColor2, blackColor1],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
