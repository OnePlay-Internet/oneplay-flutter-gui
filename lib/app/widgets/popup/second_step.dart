import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../focus_zoom/focus_zoom.dart';

class SecondStep extends StatefulWidget {
  final Function()? onTap;

  const SecondStep({
    super.key,
    this.onTap,
  });

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        Image.asset(
          imgStep2,
          height: size.height * 0.2,
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: const Text(
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
        ),
        SizedBox(
          height: size.height * 0.03,
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                    }),
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              const Text(
                'I agree to these steps.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        isChecked == false
            ? SubmitButton(
                buttonTitle: 'Agree & Continue',
                height: size.height * 0.056,
                width: size.width * 0.58,
                borderRadius: 25,
                fontSize: 14,
                colors: [
                  pinkColor1.withOpacity(0.4),
                  blueColor1.withOpacity(0.4)
                ],
              )
            : SubmitButton(
                buttonTitle: 'Agree & Continue',
                height: size.height * 0.056,
                width: size.width * 0.58,
                borderRadius: 25,
                fontSize: 14,
                onTap: widget.onTap,
              ),
      ],
    );
  }
}
