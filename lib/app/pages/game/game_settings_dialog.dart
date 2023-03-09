import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../common/common.dart';
import '../../models/game_setting.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/common_divider.dart';
import '../../widgets/focus_zoom/focus_zoom.dart';
import 'advance_game_dialog.dart';

class GameSettingsDialog extends StatefulWidget {
  final GameSetting gameSetting;
  final Function() launchGame;

  const GameSettingsDialog({
    super.key,
    required this.gameSetting,
    required this.launchGame,
  });

  @override
  State<GameSettingsDialog> createState() => _GameSettingsDialogState();
}

class _GameSettingsDialogState extends State<GameSettingsDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
      ),
      backgroundColor: mainColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      content: SizedBox(
        // height: size.height * 0.65,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.04,
                horizontal: size.width * 0.05,
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
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => isOpenDialog = false);
                        },
                        child: SvgPicture.asset(
                          crossIcon,
                          height: 20,
                          width: 20,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            commonDividerWidget(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.035,
              ),
              height: size.height * 0.048,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: redColor,
              ),
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01,
                  ),
                  child: Text(
                    'You need to own this game in steam.',
                    maxLines: 1,
                    style: tinyStyle.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.01,
                left: size.width * 0.05,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'Resolution',
                style: tinyStyle.copyWith(
                  color: textSecondaryColor,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.012,
            ),
            Container(
              height: size.height * 0.065,
              width: size.width,
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: basicLineColor,
                  width: 2,
                ),
              ),
              child: DropdownButton(
                focusColor: Colors.blue,
                isExpanded: true,
                dropdownColor: blackColor4,
                style: tinyStyle.copyWith(
                  color: textPrimaryColor,
                ),
                underline: const SizedBox.shrink(),
                value: widget.gameSetting.resolution,
                items: PlayConstants.MOBILE_RESOLUTIONS
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: tinyStyle.copyWith(
                              color: textPrimaryColor,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => widget.gameSetting.resolution = value!);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.065,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
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
                          SizedBox(
                            width: size.width * 0.06,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: widget.gameSetting.is_vsync_enabled!,
                                thumbColor: textPrimaryColor,
                                activeColor: Colors.purple,
                                onChanged: (value) {
                                  setState(() {
                                    widget.gameSetting.is_vsync_enabled = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Expanded(
                    child: Container(
                      height: size.height * 0.065,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: basicLineColor,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton(
                        focusColor: Colors.blue,
                        isExpanded: true,
                        dropdownColor: blackColor4,
                        style: tinyStyle.copyWith(
                          color: textPrimaryColor,
                        ),
                        underline: const SizedBox.shrink(),
                        value: widget.gameSetting.fps,
                        items: PlayConstants.FPS
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    "$e ${PlayConstants.fps}",
                                    style: tinyStyle.copyWith(
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => widget.gameSetting.fps = value!);
                        },
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
                  onTap: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AdvanceGameDialog(
                          gameSetting: widget.gameSetting,
                          launchGame: widget.launchGame,
                        );
                      },
                    );
                  },
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
                        SizedBox(
                          width: size.width * 0.04,
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
                vertical: size.height * 0.03,
              ),
              child: SubmitButton(
                buttonTitle: 'Launch Game',
                borderRadius: 6.0,
                onTap: () {
                  Navigator.pop(context);
                  widget.launchGame();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
