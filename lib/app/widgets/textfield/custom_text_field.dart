import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../common/common.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<String>? items;
  final TextEditingController textCtrler;
  final List<String> selectedItem;
  final TextInputType textInputType;
  final String errorText;
  final Function(String text)? onChanged;
  final Function(String text)? dropboxVisibilityCondition;

  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.textCtrler,
      this.items = const [],
      this.selectedItem = const [''],
      this.textInputType = TextInputType.text,
      this.errorText = '',
      this.onChanged,
      this.dropboxVisibilityCondition});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool onChangeText = false;
  bool isDropDownVisible = false;

  @override
  void initState() {
    if (widget.selectedItem[0].isEmpty && widget.items!.isNotEmpty) {
      widget.selectedItem[0] = widget.items![0];
    }

    super.initState();
  }

  void setDropDownVisible(bool isVisible) {
    setState(() {
      isDropDownVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isHideText = widget.textInputType == TextInputType.visiblePassword;

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
                Row(
                  children: [
                    if (isDropDownVisible && widget.items!.isNotEmpty)
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          focusColor: Colors.transparent,
                          value: widget.selectedItem[0],
                          items: widget.items!
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) => setState(() {
                            widget.selectedItem[0] = newValue!;
                          }),
                          style: const TextStyle(
                            fontFamily: mainFontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            color: textSecondaryColor,
                          ),
                        ),
                      ),
                    Expanded(
                      child: TextFormField(
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
                          suffixIcon: widget.textInputType ==
                                  TextInputType.visiblePassword
                              ? FocusZoom(
                                  builder: (focus) {
                                    return InkWell(
                                      // focusNode: focus,
                                      onTap: () {
                                        setState(
                                            () => isHideText = !isHideText);
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          isHideText
                                              ? hidePwdIcon
                                              : showPwdIcon,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ),
                        controller: widget.textCtrler,
                        keyboardType: widget.textInputType,
                        obscureText: isHideText,
                        onTap: () => setState(() => onChangeText = true),
                        onEditingComplete: () {
                          setState(() => onChangeText = false);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (String newValue) {
                          if (widget.dropboxVisibilityCondition != null) {
                            setDropDownVisible(
                                widget.dropboxVisibilityCondition!(newValue));
                          }

                          widget.onChanged;
                        },
                        style: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                        ),
                      ),
                    )
                  ],
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
