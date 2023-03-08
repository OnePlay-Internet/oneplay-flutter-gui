import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../common/common.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textCtrler;
  final TextInputType textInputType;
  final String errorText;
  final Function(String text)? onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textCtrler,
    this.textInputType = TextInputType.text,
    this.errorText = '',
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHideText = false;
  bool onChangeText = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    setState(() {
      isHideText = widget.textInputType == TextInputType.visiblePassword;
    });
    focusNode.addListener(_handleFocus);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocus);
    super.dispose();
  }

  void _handleFocus() {
    setState(() {
      onChangeText = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                widget.labelText,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 14,
                ),
              ),
              widget.errorText != ""
                  ? GradientText(
                      widget.errorText,
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
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
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
                    suffixIcon:
                        widget.textInputType == TextInputType.visiblePassword
                            ? InkWell(
                                canRequestFocus: false,
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
                              )
                            : const SizedBox(),
                  ),
                  controller: widget.textCtrler,
                  keyboardType: widget.textInputType,
                  obscureText: isHideText,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.nextFocus();
                  },
                  onChanged: widget.onChanged,
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
                        colors: widget.errorText != ''
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
  }
}
