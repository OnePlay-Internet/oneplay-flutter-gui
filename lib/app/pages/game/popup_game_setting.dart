import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplay_flutter_gui/app/models/game_setting.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';

import '../../common/common.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/common_divider.dart';
import 'advance_game_dialog.dart';

Widget gameSettingPopup(
  BuildContext context,
  GameSetting gameSetting,
  Function() launchGame,
) {
  Size size = MediaQuery.of(context).size;

  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6.0),
      ),
    ),
    backgroundColor: mainColor,
    contentPadding: EdgeInsets.zero,
    insetPadding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    content: SizedBox(
      height: size.height * 0.65,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select your game settings',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.02,
                  ),
                ),
                FocusZoom(
                  builder: (focus) {
                    return InkWell(
                      focusNode: focus,
                      autofocus: true,
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        crossIcon,
                        height: 20,
                        width: 20,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          commonDividerWidget(),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            height: 38,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: redColor,
            ),
            child: Center(
              child: Text(
                'You need to own this game in steam.',
                style: tinyStyle.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              'Resolution',
              style: tinyStyle.copyWith(
                color: textSecondaryColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: basicLineColor,
                width: 2,
              ),
            ),
            width: size.width,
            child: dropdownMenu(
              PlayConstants.MOBILE_RESOLUTIONS,
              gameSetting.resolution,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: basicLineColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Vsync',
                          style: tinyStyle.copyWith(
                            color: textPrimaryColor,
                          ),
                        ),
                        StatefulBuilder(
                          builder: (_, setState) => SizedBox(
                            height: 20,
                            width: 34,
                            child: Transform.scale(
                              scale: 0.6,
                              child: CupertinoSwitch(
                                value: gameSetting.is_vsync_enabled!,
                                thumbColor: textPrimaryColor,
                                activeColor: Colors.purple,
                                onChanged: (value) {
                                  setState(() {
                                    gameSetting.is_vsync_enabled = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: basicLineColor,
                        width: 2,
                      ),
                    ),
                    child: dropdownMenu(
                      PlayConstants.FPS,
                      gameSetting.fps,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FocusZoom(
            builder: (focus) {
              return InkWell(
                focusNode: focus,
                onTap: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AdvanceGameDialog(
                      gameSetting: gameSetting,
                      launchGame: launchGame,
                    );
                  },
                ),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        advancedSettingIcon,
                        height: 20,
                        color: textPrimaryColor,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        'Advanced game options',
                        style: tinyStyle.copyWith(
                          color: textSecondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            child: SubmitButton(
              buttonTitle: 'Launch Game',
              borderRadius: 6.0,
              onTap: () {
                Navigator.pop(context);
                launchGame();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget dropdownMenu(List<dynamic> options, dynamic selectValue) {
  return StatefulBuilder(
    builder: (context, setState) {
      return DropdownButton(
        focusColor: Colors.blue,
        isExpanded: true,
        dropdownColor: blackColor4,
        style: tinyStyle.copyWith(color: textPrimaryColor),
        underline: const SizedBox.shrink(),
        value: selectValue,
        items: options
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  "$e",
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
