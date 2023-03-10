
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../widgets/Submit_Button/submit_button.dart';
import '../../../widgets/common_divider.dart';
import '../../../widgets/footer/authFooter.dart';
import '../../../widgets/gamepad_pop/gamepad_pop.dart';
import '../../../widgets/textfield/custom_text_field.dart';

class LandscapeLoginUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passworController;
  final String errorEmail;
  final String errorPassword;
  final int? isPortrait;
  final Function(String)? onChangedEmail;
  final Function(String)? onChangedPassword;
  final bool isLoading;
  final Function()? onTapForgotPassword;
  final Function()? onTapSubmit;
  final Function()? onTapCreateAccount;

  const LandscapeLoginUi({
    super.key,
    required this.emailController,
    required this.passworController,
    required this.errorEmail,
    required this.errorPassword,
    this.isPortrait,
    this.onChangedEmail,
    this.onChangedPassword,
    this.isLoading = false,
    this.onTapForgotPassword,
    this.onTapSubmit,
    this.onTapCreateAccount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GamepadPop(
      context: context,
      child: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Log in to your account',
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
                            vertical: size.height * 0.10,
                          ),
                          child: CustomTextField(
                            labelText: 'Email / Phone',
                            hintText: 'Email Address',
                            textCtrler: emailController,
                            errorText: errorEmail,
                            onChanged: onChangedEmail,
                          ),
                        ),
                        CustomTextField(
                          labelText: 'Password',
                          hintText: 'Password',
                          textInputType: TextInputType.visiblePassword,
                          textCtrler: passworController,
                          errorText: errorPassword,
                          onChanged: onChangedPassword,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: onTapForgotPassword,
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontFamily: mainFontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: 0.02,
                                    color: textPrimaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SubmitButton(
                          buttonTitle: 'Log in',
                          loadingTitle: 'Logging you in...',
                          height: size.height * 0.14,
                          isLoading: isLoading,
                          onTap: onTapSubmit,
                        ),
                        haveAccount(
                          title: 'Don\'t have an account? ',
                          btnTitle: 'Create a New',
                          onTap: onTapCreateAccount,
                        ),
                        commonDividerWidget(),
                        needHelpWidget(),
                        authFooterWidget()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
