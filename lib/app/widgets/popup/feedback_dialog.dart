import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import 'survey_dialog.dart';

class AlertFeedbackDialog extends StatefulWidget {
  const AlertFeedbackDialog({super.key});

  @override
  State<AlertFeedbackDialog> createState() => _AlertFeedbackDialogState();
}

class _AlertFeedbackDialogState extends State<AlertFeedbackDialog> {
  List<String> ratings = ['1', '2', '3', '4', '5'];
  String selectedRating = '';
  // int index = 0;
  int isSelected = 0;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _icon(0, text: '1'),
                    _icon(1, text: '2'),
                    _icon(2, text: '3'),
                    _icon(3, text: '4'),
                    _icon(4, text: '5'),
                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: feedbackRow(
                //     size: size,
                //     feedback: ratings,
                //     value: index,
                //     onTap: (e) {
                //       setState(() => index = ratings.indexOf(e));
                //       if (index == 0) {
                //         print('***** Rating: 1 *****');

                //         selectedRating = '1';
                //       } else if (index == 1) {
                //         print('***** Rating: 2 *****');

                //         selectedRating = '2';
                //       } else if (index == 2) {
                //         print('***** Rating: 3 *****');

                //         selectedRating = '3';
                //       } else if (index == 3) {
                //         print('***** Rating: 4 *****');

                //         selectedRating = '4';
                //       } else if (index == 4) {
                //         print('***** Rating: 5 *****');

                //         selectedRating = '5';
                //       }
                //     },
                //   ),
                // ),
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
                      print('***** Selected rating: $selectedRating *****');

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertSurveyDialog(
                            feedbackRating: selectedRating,
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

  Widget _icon(int index, {String? text}) {
    Size size = MediaQuery.of(context).size;

    return InkResponse(
      onTap: () {
        selectedRating = ratings[index];

        print("***** Index: $index, Gender: $selectedRating *****");

        setState(() {
          isSelected = index;
        });
      },
      child: Container(
        height: size.height * 0.062,
        width: size.width * 0.17,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: isSelected == index
                ? [purpleColor2, purpleColor1]
                : [blackColor2, blackColor1],
          ),
        ),
        child: Center(
          child: Text(
            text!,
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
            height: size.height * 0.062,
            width: size.width * 0.17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: element.indexOf(element) == value
                    ? [blackColor2, blackColor1]
                    : [purpleColor2, purpleColor1],
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
