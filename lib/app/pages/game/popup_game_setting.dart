import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplay_flutter_gui/app/common/utils/play_constant.dart';
import 'package:oneplay_flutter_gui/app/models/game_setting.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../common/common.dart';
import '../../widgets/common_divider.dart';

Widget gameSettingPopup(
  BuildContext context,
  GameSetting gameSetting,
  Function() launchGame,
) {
  return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      backgroundColor: mainColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 38,
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
              child: dropdownMenu(
                  PlayConstants.MOBILE_RESOLUTIONS, gameSetting.resolution),
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
                      child: dropdownMenu(PlayConstants.FPS, gameSetting.fps),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            FocusZoom(builder: (focus) {
              return InkWell(
                focusNode: focus,
                onTap: () => advancedSettingPopup(
                  context,
                  gameSetting,
                  launchGame,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(advancedSettingIcon,
                            height: 20, color: textPrimaryColor),
                        const SizedBox(width: 14),
                        Text(
                          'Advanced game options',
                          style: tinyStyle.copyWith(color: textSecondaryColor),
                        )
                      ]),
                ),
              );
            }),
            btnLaunchGame(context, launchGame)
          ],
        ),
      ));
}

advancedSettingPopup(
    BuildContext context, GameSetting gameSetting, Function() launchGame) {
  bool showStats = true;
  bool fullScreenMode = true;
  bool onScreenControls = false;

  List<String> audioType = ['Stereo', '5.1'];
  List<String> streamCodec = ['Auto', 'HEVC', 'H.265'];
  List<String> videoDecode = ['Auto', 'Software', 'Hardware'];

  int audioTypeValue = 0;
  int streamCodecValue = 1;
  int videoDecodeValue = 0;

  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            backgroundColor: blackColor4,
            contentPadding: EdgeInsets.zero,
            insetPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            content: StatefulBuilder(builder: (__, setState) {
              return SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: blackColor4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40, bottom: 30, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Advanced Game Options',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: mainFontFamily,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                            FocusZoom(builder: (focus) {
                              return InkWell(
                                focusNode: focus,
                                onTap: () => Navigator.pop(context),
                                child: SvgPicture.asset(
                                  crossIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      commonDividerWidget(),
                      switchGameSetting(
                          context: context,
                          content: 'Show Stats',
                          setState: setState,
                          value: showStats,
                          onChanged: (value) =>
                              {setState(() => gameSetting.show_stats = value)}),
                      switchGameSetting(
                          context: context,
                          content: 'Fullscreen Mode',
                          setState: setState,
                          value: fullScreenMode,
                          onChanged: (value) =>
                              {setState(() => gameSetting.fullscreen = value)}),
                      switchGameSetting(
                          context: context,
                          content: 'Onscreen Controls',
                          setState: setState,
                          value: onScreenControls,
                          onChanged: (value) => {
                                setState(
                                    () => gameSetting.onscreen_controls = value)
                              }),
                      selectionGameSetting(context, 'Audio Type', audioType,
                          (e) {
                        setState(() => audioTypeValue = audioType.indexOf(e));
                        gameSetting.audio_type = e;
                      }, audioTypeValue),
                      selectionGameSetting(context, 'Stream Codec', streamCodec,
                          (e) {
                        setState(
                            () => streamCodecValue = streamCodec.indexOf(e));
                      }, streamCodecValue),
                      selectionGameSetting(
                          context, 'Video Decoder Selection', videoDecode, (e) {
                        setState(
                            () => videoDecodeValue = videoDecode.indexOf(e));
                        gameSetting.video_decoder_selection = e;
                      }, videoDecodeValue),
                      btnLaunchGame(context, launchGame),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              );
            }));
      },
      barrierDismissible: false);
}

Container selectionGameSetting(BuildContext context, String title,
    List<String> audioType, Function(String e) onTap, int audioTypeValue) {
  return Container(
    height: 88,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: tinyStyle.copyWith(color: textSecondaryColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: audioType
                .map((e) => FocusZoom(builder: (focus) {
                      return InkWell(
                        focusNode: focus,
                        onTap: () => onTap(e),
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: audioType.indexOf(e) == audioTypeValue
                                      ? purpleColor1
                                      : basicLineColor)),
                          child: GradientText(
                            e,
                            style: tinyStyle,
                            gradientType: GradientType.linear,
                            gradientDirection: GradientDirection.ltr,
                            colors: audioType.indexOf(e) == audioTypeValue
                                ? const [purpleColor2, purpleColor1]
                                : [textPrimaryColor, textPrimaryColor],
                          ),
                        ),
                      );
                    }))
                .toList(),
          )
        ]),
  );
}

Container switchGameSetting({
  required BuildContext context,
  required bool value,
  required StateSetter setState,
  required String content,
  required Function(bool value) onChanged,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 52,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: mainColor),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: tinyStyle.copyWith(color: textSecondaryColor),
          ),
          SizedBox(
            height: 20,
            width: 34,
            child: Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: value,
                thumbColor: textPrimaryColor,
                activeColor: Colors.purple,
                onChanged: onChanged,
              ),
            ),
          ),
        ]),
  );
}

FocusZoom btnLaunchGame(BuildContext context, Function() launchGame) {
  return FocusZoom(builder: (focus) {
    return InkWell(
      focusNode: focus,
      onTap: () {
        Navigator.pop(context);
        launchGame();
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
        ),
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
    );
  });
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
