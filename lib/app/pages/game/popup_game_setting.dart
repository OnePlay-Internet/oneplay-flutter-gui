import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplay_flutter_gui/main.dart';

import '../../common/common.dart';
import '../../widgets/common_divider.dart';

Widget gameSettingPopup(BuildContext context) {
  List<String> resolutionList = [
    '1280x720',
    '1920x1080',
    '2560x1440',
    '3840x2160'
  ];
  String resolutionValue = resolutionList[0];

  List<String> fpsList = ['30 FPS', '60 FPS'];
  String fpsValue = fpsList[1];
  bool isVsync = true;

  return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      backgroundColor: mainColor,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Select your game settings',
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
            ),
            commonDividerWidget(),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // height: 38,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffE31C34)),
                child: Center(
                    child: Text('You need to own this game in steam.',
                        style: tinyStyle.copyWith(fontSize: 15)))),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Resolution',
                style: tinyStyle.copyWith(color: textSecondaryColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: basicLineColor, width: 2)),
              width: MediaQuery.of(context).size.width,
              child: dropdownMenu(resolutionList, resolutionValue),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: basicLineColor, width: 2)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Vsync',
                            style: tinyStyle.copyWith(color: textPrimaryColor),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => SizedBox(
                              height: 20,
                              width: 34,
                              child: Transform.scale(
                                scale: 0.6,
                                child: CupertinoSwitch(
                                  value: isVsync,
                                  thumbColor: textPrimaryColor,
                                  activeColor: Colors.purple,
                                  onChanged: (value) {
                                    setState(() {
                                      isVsync = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: basicLineColor, width: 2)),
                      child: dropdownMenu(fpsList, fpsValue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(advancedSettingIcon,
                    height: 20, color: textPrimaryColor),
                const SizedBox(width: 14),
                Text(
                  'Advanced game options',
                  style: tinyStyle.copyWith(color: textSecondaryColor),
                )
              ]),
            ),
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [pinkColor1, blueColor1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Center(
                  child: Text(
                    'Launch Game',
                    style: tinyStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ));
}

Widget advancedSettingPopup() {
  return AlertDialog();
}

Widget dropdownMenu(List<String> options, String selectValue) {
  return StatefulBuilder(
    builder: (context, setState) {
      return DropdownButton(
        isExpanded: true,
        dropdownColor: blackColor4,
        style: tinyStyle.copyWith(color: textPrimaryColor),
        underline: const SizedBox.shrink(),
        value: selectValue,
        items: options
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: tinyStyle.copyWith(color: textPrimaryColor),
                )))
            .toList(),
        onChanged: (value) {
          setState(() => selectValue = value!);
        },
      );
    },
  );
}
