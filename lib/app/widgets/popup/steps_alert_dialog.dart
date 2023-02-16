import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';

class AlertStepsPopUp extends StatefulWidget {
  final Function()? onTap;

  const AlertStepsPopUp({
    super.key,
    this.onTap,
  });

  @override
  State<AlertStepsPopUp> createState() => _AlertStepsPopUpState();
}

class _AlertStepsPopUpState extends State<AlertStepsPopUp> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: mainColor,
      contentPadding: const EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.all(
        size.width * 0.03,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text(
              'Before you start',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Divider(
              color: basicLineColor,
              thickness: 0.6,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Image.asset(
                        imgStep1,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      const Text(
                        'Step 1',
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'You need to have 3rd party login in\norder to use OnePlay Services.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Image.asset(
                        imgStep2,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      const Text(
                        'Step 2',
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'You’ve to own the games you are\ntrying to play on those 3rd party applications.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: basicLineColor,
              thickness: 0.6,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: textSecondaryColor,
                    ),
                    child: FocusZoom(
                      zoomEffect: false,
                      builder: (_) {
                        return Checkbox(
                          focusNode: _,
                          autofocus: true,
                          value: isChecked,
                          activeColor: textSecondaryColor,
                          checkColor: Colors.black,
                          onChanged: (value) => setState(() {
                            isChecked = value!;
                          }),
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'I agree to these terms.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: mainFontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            color: textSecondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        isChecked == false
                            ? SubmitButton(
                                buttonTitle: 'Agree',
                                height: size.height * 0.048,
                                width: size.width * 0.3,
                                borderRadius: 20,
                                fontSize: 14,
                                colors: [
                                  pinkColor1.withOpacity(0.4),
                                  blueColor1.withOpacity(0.4)
                                ],
                              )
                            : SubmitButton(
                                buttonTitle: 'Agree',
                                height: size.height * 0.048,
                                width: size.width * 0.3,
                                borderRadius: 20,
                                fontSize: 14,
                                onTap: widget.onTap,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
