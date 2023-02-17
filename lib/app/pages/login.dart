import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:oneplay_flutter_gui/app/widgets/footer/authFooter.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import 'package:oneplay_flutter_gui/app/widgets/textfield/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:validators/validators.dart';

import '../services/shared_pref_service.dart';
import '../widgets/popup/steps_alert_dialog.dart';
import '../widgets/popup/popup_success.dart';
import '../widgets/Submit_Button/submit_button.dart';
import '../widgets/popup/steps_alert_dialog_2.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool isChecked = false;

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

      // Future.delayed(const Duration(milliseconds: 2000), () {
      //   setState(() => loading = false);

      //   Modular.to.navigate('/feeds');
      // });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertStepsPopUp(
            onTap: () {
              SharedPrefService.storeIsAgree(true);

              Navigator.pop(_);

              Modular.to.navigate('/feeds');
            },
          );
        },
      );
    } on DioError catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 3000), () {
            setState(() => loading = false);
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

  @override
  void initState() {
    SharedPrefService.storeIsAgree(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GamepadPop(
      context: context,
      child: SafeArea(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Modular.to.pushNamed('/auth/forgotPass'),
                      child: forgotPwd(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.105,
                ),
                child: SubmitButton(
                  buttonTitle: 'Log in',
                  loadingTitle: 'Logging you in...',
                  isLoading: loading,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
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
              ),
              haveAccount(
                title: 'Don\'t have an account? ',
                btnTitle: 'Create a New',
                onTap: () => Modular.to.pushNamed('/auth/signup'),
              ),
              commonDividerWidget(),
              needHelpWidget(),
              authFooterWidget()
            ]),
          ),
        ),
      )),
    );
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
