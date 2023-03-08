import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validators/validators.dart';

import '../../common/common.dart';
import '../../services/rest_service.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/common_divider.dart';
import '../../widgets/footer/authFooter.dart';
import '../../widgets/gamepad_pop/gamepad_pop.dart';
import '../../widgets/popup/popup_success.dart';
import '../../widgets/textfield/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final RestService _restService = Modular.get<RestService>();

  final emailController = TextEditingController();

  String errorEmail = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 8;

    return OrientationBuilder(
      builder: (context, orientation) {
        return GamepadPop(
          context: context,
          child: SafeArea(
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isPortrait == 5
                            ? size.width * 0.105
                            : size.width * 0.05,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: isPortrait == 5
                                  ? size.height * 0.04
                                  : size.height * 0.10,
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
                          customTextField(
                            labelText: 'Email',
                            hintText: 'Email Address',
                            textCtrler: emailController,
                            errorText: errorEmail,
                          ),
                          SizedBox(
                            height: isPortrait == 5
                                ? size.height * 0.05
                                : size.height * 0.1,
                          ),
                          SubmitButton(
                            buttonTitle: 'Submit',
                            loadingTitle: 'Submiting...',
                            isLoading: isLoading,
                            height: isPortrait == 5 ? null : size.height * 0.14,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              var email = emailController.text;

                              if (email.isEmpty) {
                                setState(() => errorEmail = "Enter your email");
                                return;
                              } else if (!isEmail(email)) {
                                setState(
                                    () => errorEmail = "Invalid email address");
                                return;
                              } else {
                                setState(() => errorEmail = "");
                              }

                              _forgotPassword(email);
                            },
                          ),
                        ],
                      ),
                    ),
                    haveAccount(
                      title: 'Remember password? ',
                      btnTitle: 'Log in',
                      onTap: () => Modular.to.pushNamed('/auth/login'),
                    ),
                    commonDividerWidget(),
                    needHelpWidget(),
                    authFooterWidget()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _forgotPassword(String email) async {
    setState(() => isLoading = true);

    try {
      await _restService.forgotPassword(email: email);

      Modular.to.pushReplacementNamed('/auth/sentSuccess');
    } on DioError catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 3000), () {
            setState(() => isLoading = false);
            Navigator.pop(_);
          });
          return GamepadPop(
            context: _,
            child: alertError(
              context: context,
              title: 'Login Error',
              description: e.error['message'],
            ),
          );
        },
        barrierDismissible: false,
      );
    }
  }
}