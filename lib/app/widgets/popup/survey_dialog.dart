import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../common/common.dart';
import '../../common/utils/questions.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import '../textfieldsetting/custom_text_field_setting.dart';

class AlertSurveyDialog extends StatefulWidget {
  final String feedbackRating;

  const AlertSurveyDialog({
    super.key,
    required this.feedbackRating,
  });

  @override
  State<AlertSurveyDialog> createState() => _AlertSurveyDialogState();
}

class _AlertSurveyDialogState extends State<AlertSurveyDialog> {
  String bio = '';
  String errorBio = '';

  List<String>? firstAnswer;
  List<String>? secondAnswer;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    firstAnswer = widget.feedbackRating == '1'
        ? firstAnswer = answer1
        : widget.feedbackRating == '2' || widget.feedbackRating == '2'
            ? firstAnswer = answer1
            : answer2;

    secondAnswer =
        widget.feedbackRating == '5' ? secondAnswer = answer3 : answer2;

    return AlertDialog(
      backgroundColor: mainColor,
      contentPadding: const EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.all(
        size.width * 0.05,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Image.asset(
              feedbackPng,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Text(
              'We would love your feedback',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textPrimaryColor,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Text(
                'Our goal is to make a platform that simplifies experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03,
              ),
              child: commonDividerWidget(),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.feedbackRating == '1'
                              ? question1
                              : widget.feedbackRating == '2' ||
                                      widget.feedbackRating == '2'
                                  ? question1
                                  : widget.feedbackRating == '3' ||
                                          widget.feedbackRating == '3'
                                      ? question3
                                      : widget.feedbackRating == '4' ||
                                              widget.feedbackRating == '4'
                                          ? question5
                                          : question7,
                          style: const TextStyle(
                            fontFamily: mainFontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            color: textPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: answerRow1(
                          size: size,
                          answer: firstAnswer!,
                          value: index,
                          onTap: (e) {
                            setState(() => index = firstAnswer!.indexOf(e));

                            if (index == 0) {
                              print('***** Answer: Answer 1 *****');
                            } else if (index == 1) {
                              print('***** Answer: Answer 2 *****');
                            } else if (index == 2) {
                              print('***** Answer: Answer 3 *****');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.feedbackRating == '1'
                              ? question2
                              : widget.feedbackRating == '2' ||
                                      widget.feedbackRating == '2'
                                  ? question2
                                  : widget.feedbackRating == '3' ||
                                          widget.feedbackRating == '3'
                                      ? question4
                                      : widget.feedbackRating == '4' ||
                                              widget.feedbackRating == '4'
                                          ? question6
                                          : question8,
                          style: const TextStyle(
                            fontFamily: mainFontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            color: textPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: answerRow2(
                          size: size,
                          answer2: secondAnswer!,
                          value: index,
                          onTap: (e) {
                            setState(() => index = secondAnswer!.indexOf(e));

                            if (index == 0) {
                              print('***** Answer: Answer 1 *****');
                            } else if (index == 1) {
                              print('***** Answer: Answer 2 *****');
                            } else if (index == 2) {
                              print('***** Answer: Answer 3 *****');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: settingsTextField(
                        context: context,
                        height: size.height * 0.09,
                        textFieldTitle: 'Manual Answer',
                        hintText: 'Write a short answer',
                        errorMessage: errorBio,
                        expands: true,
                        maxLines: null,
                        controller: TextEditingController(text: bio),
                        onChanged: (value) {
                          bio = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.04,
                      ),
                      child: commonDividerWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Skip Survey',
                              style: TextStyle(
                                fontFamily: mainFontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.02,
                                color: textPrimaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SubmitButton(
                            width: size.width * 0.38,
                            buttonTitle: 'Submit',
                            onTap: () {
                              print(
                                  '***** Feedback rating: ${widget.feedbackRating} *****');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> answerRow1({
    required Size size,
    required List<String> answer,
    required Function(String e) onTap,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in answer) {
      if (element.indexOf(element) > 0 &&
          element.indexOf(element) < element.length) {
        widgets.add(
          const SizedBox(
            width: 30,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap(element),
          child: Container(
            height: size.height * 0.065,
            width: widget.feedbackRating == '1'
                ? null
                : widget.feedbackRating == '2' || widget.feedbackRating == '2'
                    ? null
                    : size.width * 0.38,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.045,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: element.indexOf(element) == value
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
                colors: element.indexOf(element) == value
                    ? const [purpleColor2, purpleColor1]
                    : [textPrimaryColor, textPrimaryColor],
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> answerRow2({
    required Size size,
    required List<String> answer2,
    required Function(String e) onTap,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in answer2) {
      if (element.indexOf(element) > 0 &&
          element.indexOf(element) < element.length) {
        widgets.add(
          const SizedBox(
            width: 30,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap(element),
          child: Container(
            height: size.height * 0.065,
            width: size.width * 0.38,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.018,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: element.indexOf(element) == value
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
                colors: element.indexOf(element) == value
                    ? const [purpleColor2, purpleColor1]
                    : [textPrimaryColor, textPrimaryColor],
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}
