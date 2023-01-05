import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/common.dart';

StatefulBuilder customTextField({
  required String labelText,
  required String hintText,
  required TextEditingController textCtrler,
  TextInputType textInputType = TextInputType.text,
}) {
  bool isHideText = textInputType == TextInputType.visiblePassword;
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter stateSetter) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      height: 84,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,
              style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: greyColor2)),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: greyColor1),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: blackColor1, width: 2),
                ),
                suffixIcon: textInputType == TextInputType.visiblePassword
                    ? InkWell(
                        onTap: () {
                          stateSetter(() => isHideText = !isHideText);
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            showPwdIcon,
                            color: greyColor2,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              controller: textCtrler,
              obscureText: isHideText,
              style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  });
}
