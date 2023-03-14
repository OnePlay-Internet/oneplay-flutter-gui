import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/fake_focus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../main.dart';
import '../../common/common.dart';
import '../../models/game_setting.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/common_divider.dart';
import '../../widgets/focus_zoom/focus_zoom.dart';

class AdvanceGameDialog extends StatefulWidget {
  final GameSetting gameSetting;
  final Function() launchGame;

  const AdvanceGameDialog({
    super.key,
    required this.gameSetting,
    required this.launchGame,
  });

  @override
  State<AdvanceGameDialog> createState() => _AdvanceGameDialogState();
}

class _AdvanceGameDialogState extends State<AdvanceGameDialog> {
  List<String> audioType = ['Stereo', '5.1 Channel'];
  List<String> streamCodec = ['Auto', 'HEVC', 'H.265'];
  List<String> videoDecode = ['Auto', 'Software', 'Hardware'];

  int audioTypeValue = 0;
  int streamCodecValue = 1;
  int videoDecodeValue = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: blackColor4,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
      ),
      insetPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.05,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: blackColor4,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      'Advanced Game Options',
                      style: TextStyle(
                        color: whiteColor2,
                        fontSize: 18,
                        fontFamily: mainFontFamily,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FocusZoom(
                      builder: (focus) {
                        return InkWell(
                          focusNode: focus,
                          autofocus: true,
                          onTap: () {
                            Navigator.pop(context);
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
              switchGameSetting(
                context: context,
                content: 'Show Stats',
                setState: setState,
                value: widget.gameSetting.show_stats!,
                onChanged: (value) {
                  setState(() => widget.gameSetting.show_stats = value);
                },
              ),
              switchGameSetting(
                context: context,
                content: 'Fullscreen Mode',
                setState: setState,
                value: widget.gameSetting.fullscreen!,
                onChanged: (value) {
                  setState(() => widget.gameSetting.fullscreen = value);
                },
              ),
              switchGameSetting(
                context: context,
                content: 'Onscreen Controls',
                setState: setState,
                value: widget.gameSetting.onscreen_controls!,
                onChanged: (value) {
                  setState(() => widget.gameSetting.onscreen_controls = value);
                },
              ),
              audioTypeSelection(
                context,
                'Audio Type',
                audioType,
                (e) {
                  setState(() => audioTypeValue = audioType.indexOf(e));
                  widget.gameSetting.audio_type = e;
                },
                audioTypeValue,
              ),
              streamCodesSelection(
                context,
                'Stream Codec',
                streamCodec,
                (e) {
                  setState(() => streamCodecValue = streamCodec.indexOf(e));
                  widget.gameSetting.stream_codec = e;
                },
                streamCodecValue,
              ),
              videoDecoderSelection(
                context,
                'Video Decoder Selection',
                videoDecode,
                (e) {
                  setState(() => videoDecodeValue = videoDecode.indexOf(e));
                  widget.gameSetting.video_decoder_selection = e;
                },
                videoDecodeValue,
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
                    widget.launchGame();
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.022,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container switchGameSetting({
    required BuildContext context,
    required bool value,
    required StateSetter setState,
    required String content,
    required Function(bool value) onChanged,
  }) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.064,
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.012,
        horizontal: size.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: Text(
              content,
              style: tinyStyle.copyWith(
                color: textSecondaryColor,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Padding(
              padding: EdgeInsets.all(
                size.width * 0.04,
              ),
              child: FakeFocus(
                child: CupertinoSwitch(
                  value: value,
                  thumbColor: textPrimaryColor,
                  activeColor: purpleColor1,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container audioTypeSelection(
    BuildContext context,
    String title,
    List<String> audioType,
    Function(String e) onTap,
    int audioTypeValue,
  ) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.109,
      width: size.width,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.019,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: tinyStyle.copyWith(
              color: textSecondaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: addAudioTypeWidget(
              size,
              audioType,
              onTap,
              audioTypeValue,
            ),
          ),
        ],
      ),
    );
  }

  Container streamCodesSelection(
    BuildContext context,
    String title,
    List<String> audioType,
    Function(String e) onTap,
    int audioTypeValue,
  ) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.109,
      width: size.width,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.019,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: tinyStyle.copyWith(
              color: textSecondaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: addStreamCodesWidget(
              size,
              audioType,
              onTap,
              audioTypeValue,
            ),
          ),
        ],
      ),
    );
  }

  Container videoDecoderSelection(
    BuildContext context,
    String title,
    List<String> audioType,
    Function(String e) onTap,
    int audioTypeValue,
  ) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.109,
      width: size.width,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.019,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: tinyStyle.copyWith(
              color: textSecondaryColor,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: addVideoDecoderWidget(
                size,
                audioType,
                onTap,
                audioTypeValue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> addAudioTypeWidget(
    Size size,
    List<String> data,
    Function(String e) onTap,
    int value,
  ) {
    List<Widget> widgets = [];
    for (var element in data) {
      if (data.indexOf(element) > 0 && data.indexOf(element) < data.length) {
        widgets.add(const SizedBox(
          width: 0,
        ));
      }
      widgets.add(
        FocusZoom(
          builder: (f) {
            return InkWell(
              focusNode: f,
              onTap: () => onTap(element),
              child: Container(
                height: size.height * 0.065,
                width: size.width * 0.38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: data.indexOf(element) == value
                        ? purpleColor1
                        : basicLineColor,
                  ),
                ),
                child: Center(
                  child: GradientText(
                    element,
                    style: tinyStyle,
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ltr,
                    colors: data.indexOf(element) == value
                        ? const [purpleColor2, purpleColor1]
                        : [textPrimaryColor, textPrimaryColor],
                  ),
                ),
              ),
            );
          }
        ),
      );
    }
    return widgets;
  }

  List<Widget> addStreamCodesWidget(
    Size size,
    List<String> data,
    Function(String e) onTap,
    int value,
  ) {
    List<Widget> widgets = [];
    for (var element in data) {
      if (data.indexOf(element) > 0 && data.indexOf(element) < data.length) {
        widgets.add(const SizedBox(
          width: 0,
        ));
      }
      widgets.add(
        FocusZoom(
          builder: (f) {
            return InkWell(
              focusNode: f,
              onTap: () => onTap(element),
              child: Container(
                height: size.height * 0.065,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: data.indexOf(element) == value
                        ? purpleColor1
                        : basicLineColor,
                  ),
                ),
                child: Center(
                  child: GradientText(
                    element,
                    style: tinyStyle,
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ltr,
                    colors: data.indexOf(element) == value
                        ? const [purpleColor2, purpleColor1]
                        : [textPrimaryColor, textPrimaryColor],
                  ),
                ),
              ),
            );
          }
        ),
      );
    }
    return widgets;
  }

  List<Widget> addVideoDecoderWidget(
    Size size,
    List<String> data,
    Function(String e) onTap,
    int value,
  ) {
    List<Widget> widgets = [];
    for (var element in data) {
      if (data.indexOf(element) > 0 && data.indexOf(element) < data.length) {
        widgets.add(const SizedBox(
          width: 0,
        ));
      }
      widgets.add(
        FocusZoom(
          builder: (f) {
            return InkWell(
              focusNode: f,
              onTap: () => onTap(element),
              child: Container(
                height: size.height * 0.065,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: data.indexOf(element) == value
                        ? purpleColor1
                        : basicLineColor,
                  ),
                ),
                child: Center(
                  child: GradientText(
                    element,
                    style: tinyStyle,
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ltr,
                    colors: data.indexOf(element) == value
                        ? const [purpleColor2, purpleColor1]
                        : [textPrimaryColor, textPrimaryColor],
                  ),
                ),
              ),
            );
          }
        ),
      );
    }
    return widgets;
  }
}
