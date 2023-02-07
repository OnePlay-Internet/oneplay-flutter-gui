// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:oneplay_flutter_gui/app/widgets/footer/authFooter.dart';
import 'package:oneplay_flutter_gui/app/widgets/textfield/custom_text_field.dart';
import 'package:validators/validators.dart';

import '../widgets/popup/popup_success.dart';
import '../widgets/submit_button/submit_button.dart';
import 'forgot_password.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isSavePwd = false;

  final idCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();

  String errorEmail = "";
  String errorPwd = "";

  login(String id, String password) async {
    final RestService restService = Modular.get<RestService>();
    final AuthService authService = Modular.get<AuthService>();

    setState(() => loading = true);

    try {
      String token = await restService.login(id: id, password: password);
      await authService.login(token);
      showDialog(
        context: context,
        builder: (_) => alertSuccess(
          context: context,
          title: 'Login Success',
          description: 'You will be redirect to Feed Page',
        ),
        barrierDismissible: false,
      );

      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() => loading = false);

        Modular.to.navigate('/feeds');
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 3000), () {
            setState(() => loading = false);

            Navigator.pop(_);
          });

          return alertError(
            context: context,
            title: 'Login Error',
            description: 'Please check your email, password and try again',
          );
        },
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(
        child: SingleChildScrollView(
          child: Column(children: [
            headTitle(),
            const SizedBox(height: 40),
            customTextField(
              labelText: 'Email / Phone',
              hintText: 'Email Address',
              textCtrler: idCtrler,
              errorText: errorEmail,
            ),
            const SizedBox(height: 40),
            customTextField(
              labelText: 'Password',
              hintText: 'Password',
              textCtrler: pwdCtrler,
              textInputType: TextInputType.visiblePassword,
              errorText: errorPwd,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  savePwd(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: forgotPwd(),
                  )
                ],
              ),
            ),
            SubmitButton(
              buttonTitle: 'Log in',
              loadingTitle: 'Logging you in...',
              isLoading: loading,
              onTap: () {
                if (!isEmail(idCtrler.text)) {
                  setState(() => errorEmail = "Invalid email address");
                  return;
                }
                if (idCtrler.text.isEmpty) {
                  setState(() => errorEmail = "Enter your email");
                  return;
                }
                if (pwdCtrler.text.isEmpty) {
                  setState(() => errorPwd = "Enter your password");
                  return;
                }
                login(idCtrler.text.trim(), pwdCtrler.text.trim());
              },
            ),
            haveAccount(
              title: 'Don\'t have an account? ',
              btnTitle: 'Create a New',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
            ),
            commonDividerWidget(),
            needHelpWidget(),
            authFooterWidget()
          ]),
        ),
      ),
    ));
  }

  Text forgotPwd() {
    return const Text(
      'Forgot Password?',
      style: TextStyle(
        fontFamily: mainFontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.02,
        color: textPrimaryColor,
      ),
    );
  }

  Row savePwd() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          width: 34,
          child: Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: isSavePwd,
              thumbColor: textPrimaryColor,
              activeColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  isSavePwd = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Remember me ',
          style: TextStyle(
            fontFamily: mainFontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.02,
            color: textSecondaryColor,
          ),
        )
      ],
    );
  }

  Container headTitle() {
    return Container(
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
    );
  }
}
