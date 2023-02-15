import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';

import '../Submit_Button/submit_button.dart';

AlertDialog alertSuccess({
  required BuildContext context,
  required String title,
  required String description,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            successPopupPng,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

AlertDialog alertGamePopUp({
  required BuildContext context,
  required Function()? onTap,
  required bool isChecked,
  required void Function(bool?)? onChanged,
}) {
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
                Checkbox(
                  activeColor: textSecondaryColor,
                  value: isChecked,
                  onChanged: onChanged,
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
                              onTap: onTap,
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

class ImageContainer extends StatelessWidget {
  final String iconPath;

  const ImageContainer({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.082,
      width: size.width * 0.18,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: basicLineColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Image.asset(
        iconPath,
      ),
    );
  }
}

AlertDialog alertError({
  required BuildContext context,
  required String title,
  required String description,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48.0),
      ),
    ),
    backgroundColor: mainColor,
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            errorPopupPng,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
