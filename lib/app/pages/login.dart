// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:oneplay_flutter_gui/app/widgets/footer/authFooter.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import 'package:oneplay_flutter_gui/app/widgets/textfield/custom_text_field.dart';

import 'package:validators/validators.dart';

import '../../main.dart';
import '../models/user_model.dart';
import '../services/shared_pref_service.dart';
import '../widgets/popup/popup_success.dart';
import '../widgets/Submit_Button/submit_button.dart';
import '../widgets/popup/steps_alert_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RestService restService = Modular.get<RestService>();
  final AuthService authService = Modular.get<AuthService>();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  UserModel? userModel;

  bool loading = false;

  final idCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();

  String errorEmail = "";
  String errorPwd = "";
  List<String> userIdList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      // onWillPop: () => exitDialog(context),
      onWillPop: () async {
        MethodChannel channel = const MethodChannel('flutter-gui');
        channel.invokeMethod("closeApp");
        return true;
      },
      child: GamepadPop(
        context: context,
        child: SafeArea(
            child: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            child: SingleChildScrollView(
              child: Column(children: [
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
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.105,
                  ),
                  child: SubmitButton(
                    buttonTitle: 'Log in',
                    loadingTitle: 'Logging you in...',
                    isLoading: loading,
                    onTap: () async {
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
      ),
    );
  }

  @override
  void initState() {
    SharedPrefService.storeIsAgree(false);
    imageURL.addListener(() => updateURL(imageURL.value));
    super.initState();
  }

  updateURL(String url) {
    if (mounted) {
      setState(() => profilePicURL = url);
    }
  }

  _getUserProfile() async {
    final res = await restService.getProfile();

    imageURL.value = res.photo.toString();

    setState(() {
      userModel = res;
    });
  }

  login(String id, String password) async {
    setState(() => loading = true);

    try {
      String token = await restService.login(
        id: id,
        password: password,
      );

      await authService.login(token);

      _getUserProfile();

      userIdList = SharedPrefService.getUserId() ?? [];

      if (userIdList.contains(AuthService().userIdToken!.userId)) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (_) => alertSuccess(
              context: context,
              title: 'Login Success',
              description: 'You will be redirect to Feed Page',
            ),
            barrierDismissible: false,
          );
        }

        Future.delayed(const Duration(milliseconds: 2000), () {
          setState(() => loading = false);

          print('***** Login event: 1 *****');

          analytics.logEvent(
            name: 'log_in',
            parameters: {
              "user_id": userModel!.id.toString(),
              "partner_id": userModel!.partnerId.toString(),
            },
          );

          print('***** Login event: 2 *****');

          SharedPrefService.storeIsAgree(true);

          Modular.to.navigate('/feeds');
        });
      } else {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertStepsPopUp(
                onTap: () {
                  userIdList.addAll([AuthService().userIdToken!.userId]);

                  SharedPrefService.storeUserId(userIdList);
                  SharedPrefService.storeIsAgree(true);

                  Navigator.pop(_);

                  Modular.to.navigate('/feeds');
                },
              );
            },
          );
        }
      }
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
}
