// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../common/common.dart';
import '../widgets/common_divider.dart';
import '../widgets/footer/authFooter.dart';
import '../widgets/submit_button/submit_button.dart';
import '../widgets/textfield/custom_text_field.dart';
import 'email_send_success.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String errorEmail = "";
  bool isLoading = false;

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.02,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.11,
                ),
                child: const Text(
                  'Enter the email address associated with your account.',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              customTextField(
                labelText: 'Email / Phone',
                hintText: 'Email Address',
                textCtrler: emailController,
                errorText: errorEmail,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SubmitButton(
                buttonTitle: 'Submit',
                loadingTitle: 'Submiting...',
                isLoading: isLoading,
                onTap: () {
                  print("***** Signing up *****");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmailSentSuccess(),
                    ),
                  );

                  // if (!isEmail(emailController.text)) {
                  //   setState(() => errorEmail = "Invalid email address");

                  //   return;
                  // }

                  // if (emailController.text.isEmpty) {
                  //   setState(() => errorEmail = "Enter your email");

                  //   return;
                  // }

                  // print("***** Call api.. *****");
                },
              ),
              haveAccount(
                title: 'Remember password? ',
                btnTitle: 'Log in',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
              commonDividerWidget(),
              needHelpWidget(),
              authFooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
