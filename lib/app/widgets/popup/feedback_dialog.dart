// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import 'survey_dialog.dart';

class AlertFeedbackDialog extends StatefulWidget {
  final String gameId;
  final String userId;
  final String sessionId;

  const AlertFeedbackDialog({
    super.key,
    required this.gameId,
    required this.userId,
    required this.sessionId,
  });

  @override
  State<AlertFeedbackDialog> createState() => _AlertFeedbackDialogState();
}

class _AlertFeedbackDialogState extends State<AlertFeedbackDialog> {
  List<String> ratings = ['1', '2', '3', '4', '5'];
  String selectedRating = '5';
  int index = 4;

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
        height: size.height * 0.71,
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '*Did you enjoy using Oneplay?',
                  style: TextStyle(
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
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: feedbackRow(
                  size: size,
                  feedback: ratings,
                  value: index,
                  onTap: (e) {
                    setState(() => index = ratings.indexOf(e));
                    if (index == 0) {
                      selectedRating = '1';
                    } else if (index == 1) {
                      selectedRating = '2';
                    } else if (index == 2) {
                      selectedRating = '3';
                    } else if (index == 3) {
                      selectedRating = '4';
                    } else if (index == 4) {
                      selectedRating = '5';
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Disagree',
                    style: TextStyle(
                      fontFamily: mainFontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Agree',
                    style: TextStyle(
                      fontFamily: mainFontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
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
                    buttonTitle: 'Next',
                    colors: const [blackColor2, blackColor1],
                    onTap: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertSurveyDialog(
                            feedbackRating: selectedRating,
                            gameId: widget.gameId,
                            userId: widget.userId,
                            sessionId: widget.sessionId,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> feedbackRow({
    required Size size,
    required List<String> feedback,
    required Function(String e) onTap,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in feedback) {
      if (feedback.indexOf(element) > 0 &&
          feedback.indexOf(element) < feedback.length) {
        widgets.add(
          const SizedBox(
            width: 0,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap(element),
          child: Container(
            height: size.height * 0.062,
            width: size.width * 0.17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: feedback.indexOf(element) == value
                    ? [purpleColor2, purpleColor1]
                    : [blackColor2, blackColor1],
              ),
            ),
            child: Center(
              child: Text(
                element,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}
