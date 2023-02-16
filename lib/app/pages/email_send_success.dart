import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';

import '../common/common.dart';

class EmailSentSuccess extends StatefulWidget {
  const EmailSentSuccess({super.key});

  @override
  State<EmailSentSuccess> createState() => _EmailSentSuccessState();
}

class _EmailSentSuccessState extends State<EmailSentSuccess> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GamepadPop(
      context: context,
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              successPopupPng,
              width: size.width * 0.20,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text(
              'Recovery',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const Text(
              'Email Sent',
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
            const Text(
              'We\'ve sent you instructions on',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
            ),
            const Text(
              'your email address.',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    _navigateToLogin();
    super.initState();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Modular.to.pushNamedAndRemoveUntil('/auth/login', (route) => false);
    });
  }
}
