// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../common/common.dart';
import '../../services/rest_service.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import '../textfieldsetting/custom_text_field_setting.dart';
import 'popup_success.dart';

class AlertSurveyDialog extends StatefulWidget {
  final String feedbackRating;
  final String gameId;
  final String userId;
  final String sessionId;

  const AlertSurveyDialog({
    super.key,
    required this.feedbackRating,
    required this.gameId,
    required this.userId,
    required this.sessionId,
  });

  @override
  State<AlertSurveyDialog> createState() => _AlertSurveyDialogState();
}

class _AlertSurveyDialogState extends State<AlertSurveyDialog> {
  final RestService _restService = Modular.get<RestService>();

  String comment = '';
  String errorComment = '';
  bool isLoading = false;

  String? firsAnswer;
  String? secondAnswer;

  String? firstQuestion;
  String? secondQuestion;
  int? rating;

  List<String>? firstAnswerList;
  List<String>? secondAnswerList;

  int index = 0;
  int index2 = 0;

  @override
  void initState() {
    super.initState();
    rating = int.parse(widget.feedbackRating);

    firstQuestion = widget.feedbackRating == '1'
        ? question1
        : widget.feedbackRating == '2' || widget.feedbackRating == '2'
            ? question1
            : widget.feedbackRating == '3' || widget.feedbackRating == '3'
                ? question3
                : widget.feedbackRating == '4' || widget.feedbackRating == '4'
                    ? question5
                    : question7;

    secondQuestion = widget.feedbackRating == '1'
        ? question2
        : widget.feedbackRating == '2' || widget.feedbackRating == '2'
            ? question2
            : widget.feedbackRating == '3' || widget.feedbackRating == '3'
                ? question4
                : widget.feedbackRating == '4' || widget.feedbackRating == '4'
                    ? question6
                    : question8;

    firstAnswerList = widget.feedbackRating == '1'
        ? firstAnswerList = answer1
        : widget.feedbackRating == '2' || widget.feedbackRating == '2'
            ? firstAnswerList = answer1
            : answer2;

    secondAnswerList =
        widget.feedbackRating == '5' ? secondAnswerList = answer3 : answer2;

    firsAnswer = firstAnswerList![0];
    secondAnswer = secondAnswerList![0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                          firstQuestion!,
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
                          answer: firstAnswerList!,
                          value: index,
                          onTap: (e) {
                            setState(() => index = firstAnswerList!.indexOf(e));

                            if (index == 0) {
                              firsAnswer = firstAnswerList![index];
                            } else if (index == 1) {
                              firsAnswer = firstAnswerList![index];
                            } else if (index == 2) {
                              firsAnswer = firstAnswerList![index];
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
                          secondQuestion!,
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
                          answer2: secondAnswerList!,
                          value: index2,
                          onTap2: (e) {
                            setState(
                                () => index2 = secondAnswerList!.indexOf(e));

                            if (index2 == 0) {
                              secondAnswer = secondAnswerList![index2];
                            } else if (index2 == 1) {
                              secondAnswer = secondAnswerList![index2];
                            } else if (index2 == 2) {
                              secondAnswer = secondAnswerList![index2];
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
                        errorMessage: errorComment,
                        expands: true,
                        maxLines: null,
                        controller: TextEditingController(text: comment),
                        onChanged: (value) {
                          comment = value;
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
                            loadingTitle: 'Submiting...',
                            isLoading: isLoading,
                            onTap: () {
                              _feedBack(
                                gameId: widget.gameId,
                                userId: widget.userId,
                                sessionId: widget.sessionId,
                                rating: rating!,
                                suggestion: '',
                                comment: comment,
                                question: firstQuestion!,
                                answer: firsAnswer!,
                                question2: secondQuestion!,
                                answer2: secondAnswer!,
                              );
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

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _feedBack({
    required String gameId,
    required String userId,
    required String sessionId,
    required int rating,
    required String suggestion,
    required String comment,
    required String question,
    required String answer,
    required String question2,
    required String answer2,
  }) async {
    setState(() => isLoading = true);

    try {
      await _restService.feedBack(
        gameId: gameId,
        userId: userId,
        sessionId: sessionId,
        rating: rating,
        suggestion: suggestion,
        comment: comment,
        question: question,
        answer: answer,
        question2: question2,
        answer2: answer2,
      );
      if (mounted) {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (_) {
            Future.delayed(const Duration(milliseconds: 2000), () {
              setState(() => isLoading = false);
              Navigator.pop(_);
            });

            return alertSuccess(
              context: context,
              title: 'Feedback created',
              description: 'Feedback created successfuly',
            );
          },
          barrierDismissible: false,
        );
      }
    } on DioError catch (e) {
      print('***** Exeption error: $e *****');

      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            setState(() => isLoading = false);
            Navigator.pop(_);
          });

          return alertError(
            context: context,
            title: 'Feedback failed',
            description: 'Failed to created feedback',
          );
        },
        barrierDismissible: false,
      );
    }
  }

  List<Widget> answerRow1({
    required Size size,
    required List<String> answer,
    required Function(String e) onTap,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in answer) {
      if (answer.indexOf(element) > 0 &&
          answer.indexOf(element) < answer.length) {
        widgets.add(const SizedBox(
          width: 0,
        ));
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
                color: answer.indexOf(element) == value
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
                colors: answer.indexOf(element) == value
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
    required Function(String e) onTap2,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in answer2) {
      if (answer2.indexOf(element) > 0 &&
          answer2.indexOf(element) < answer2.length) {
        widgets.add(
          const SizedBox(
            width: 0,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap2(element),
          child: Container(
            height: size.height * 0.065,
            width: size.width * 0.38,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.018,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: answer2.indexOf(element) == value
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
                colors: answer2.indexOf(element) == value
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
