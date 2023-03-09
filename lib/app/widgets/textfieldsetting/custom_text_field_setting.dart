import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/common.dart';
import '../focus_zoom/focus_zoom.dart';
import '../gradient_text_button/gradient_text_button.dart';

StatefulBuilder settingsTextField({
  required BuildContext context,
  double? height,
  String? textFieldTitle,
  TextEditingController? controller,
  Function(String)? onChanged,
  String errorMessage = '',
  String? hintText,
  bool expands = false,
  bool enabled = true,
  int? maxLines = 1,
  Color? color,
  TextInputType textInputType = TextInputType.text,
}) {
  Size size = MediaQuery.of(context).size;

  double containerHeight = height ?? size.height * 0.06;

  bool isHideText = textInputType == TextInputType.visiblePassword;

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                ),
                child: textFieldTitle != null
                    ? Text(
                        textFieldTitle,
                        style: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textPrimaryColor,
                          fontSize: 14,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              errorMessage != ''
                  ? GradientTextButton(
                      title: errorMessage,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Container(
            height: containerHeight,
            width: size.width,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            decoration: BoxDecoration(
              color: color ?? blackColor4,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: TextFormField(
                focusNode: FocusNode(),
                enabled: enabled,
                expands: expands,
                maxLines: maxLines,
                controller: controller,
                onChanged: onChanged,
                keyboardType: textInputType,
                obscureText: isHideText,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixIcon: textInputType == TextInputType.visiblePassword
                      ? FocusZoom(
                          builder: (focus) {
                            return InkWell(
                              focusNode: focus,
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
                      : textInputType == TextInputType.emailAddress ||
                              textInputType == TextInputType.emailAddress
                          ? Container(
                              height: 2,
                              width: 2,
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                checkedPng,
                              ),
                            )
                          : textInputType == TextInputType.name ||
                                  textInputType == TextInputType.name
                              ? Container(
                                  height: 2,
                                  width: 2,
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    editPng,
                                    fit: BoxFit.cover,
                                    height: size.height * 0.024,
                                  ),
                                )
                              : textInputType == TextInputType.phone ||
                                      textInputType == TextInputType.phone
                                  ? Container(
                                      height: 2,
                                      width: 2,
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        editPng,
                                        fit: BoxFit.cover,
                                        height: size.height * 0.024,
                                      ),
                                    )
                                  : null,
                  hintStyle: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
