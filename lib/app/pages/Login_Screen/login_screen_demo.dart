// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

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
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:validators/validators.dart';

import '../../../main.dart';
import '../../models/user_model.dart';
import '../../services/shared_pref_service.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/appbar/appbarWidget.dart';
import '../../widgets/popup/popup_success.dart';
import '../../widgets/popup/steps_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final RestService restService = Modular.get<RestService>();
  final AuthService authService = Modular.get<AuthService>();

  final idCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();

  String errorEmail = "";
  String errorPwd = "";

  List<String> userIdList = [];

  UserModel? userModel;

  bool loading = false;

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
      child: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Scaffold(
            backgroundColor: mainColor,
            appBar: isPortrait
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(100.0),
                    child: AppBarWidget().logoWidget(context),
                  )
                : null,
            body: isPortrait
                ? GamepadPop(
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
                                        onTap: () => Modular.to
                                            .pushNamed('/auth/forgotPass'),
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
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      if (!isEmail(idCtrler.text)) {
                                        setState(() => errorEmail =
                                            "Invalid email address");
                                        return;
                                      }
                                      if (idCtrler.text.isEmpty) {
                                        setState(() =>
                                            errorEmail = "Enter your email");
                                        return;
                                      }
                                      if (pwdCtrler.text.isEmpty) {
                                        setState(() =>
                                            errorPwd = "Enter your password");
                                        return;
                                      }

                                      login(idCtrler.text.trim(),
                                          pwdCtrler.text.trim());
                                    },
                                  ),
                                ),
                                haveAccount(
                                  title: 'Don\'t have an account? ',
                                  btnTitle: 'Create a New',
                                  onTap: () =>
                                      Modular.to.pushNamed('/auth/signup'),
                                ),
                                commonDividerWidget(),
                                needHelpWidget(),
                                authFooterWidget()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SafeArea(
                    child: SizedBox(
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  loginSignUpPng,
                                  width: size.width * 0.5,
                                ),
                                Expanded(
                                  child: GamepadPop(
                                    context: context,
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
                                                textInputType: TextInputType
                                                    .visiblePassword,
                                                errorText: errorPwd,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () => Modular.to
                                                          .pushNamed(
                                                              '/auth/forgotPass'),
                                                      child: const Text(
                                                        'Forgot Password?',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              mainFontFamily,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          letterSpacing: 0.02,
                                                          color:
                                                              textPrimaryColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.105,
                                                ),
                                                child: SubmitButton(
                                                  buttonTitle: 'Log in',
                                                  loadingTitle:
                                                      'Logging you in...',
                                                  height: size.height * 0.12,
                                                  isLoading: loading,
                                                  onTap: () async {
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();

                                                    if (!isEmail(
                                                        idCtrler.text)) {
                                                      setState(() => errorEmail =
                                                          "Invalid email address");
                                                      return;
                                                    }
                                                    if (idCtrler.text.isEmpty) {
                                                      setState(() => errorEmail =
                                                          "Enter your email");
                                                      return;
                                                    }
                                                    if (pwdCtrler
                                                        .text.isEmpty) {
                                                      setState(() => errorPwd =
                                                          "Enter your password");
                                                      return;
                                                    }

                                                    login(idCtrler.text.trim(),
                                                        pwdCtrler.text.trim());
                                                  },
                                                ),
                                              ),
                                              haveAccount(
                                                title:
                                                    'Don\'t have an account? ',
                                                btnTitle: 'Create a New',
                                                onTap: () => Modular.to
                                                    .pushNamed('/auth/signup'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: size.height * 0.03,
                              left: size.width * 0.06,
                              child: Row(
                                children: [
                                  Image.asset(
                                    logoPng,
                                    height: size.height * 0.065,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.015,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        betatagPng,
                                        height: size.height * 0.048,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      const Text(
                                        'Need help? ',
                                        style: TextStyle(
                                          fontFamily: mainFontFamily,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.02,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _launchURL(
                                            'https://www.oneplay.in/contact.html'),
                                        child: GradientText(
                                          'Browse FAQ',
                                          style: const TextStyle(
                                            fontFamily: mainFontFamily,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.02,
                                            decorationThickness: 1,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          gradientType: GradientType.linear,
                                          gradientDirection:
                                              GradientDirection.ltr,
                                          colors: const [
                                            purpleColor2,
                                            purpleColor1
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: size.height * 0.23,
                              left: size.width * 0.10,
                              child: const Text(
                                'Enjoy Uninterrupted \nGaming',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: mainFontFamily,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.02,
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: size.height * 0.03,
                              left: size.width * 0.05,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    '© 2022 RainBox Media Pvt Ltd. All Rights Reserved.',
                                    style: TextStyle(
                                      fontFamily: mainFontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.02,
                                      color: whiteColor1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _launchURL(
                                            'https://www.oneplay.in/privacy.html'),
                                        child: GradientText(
                                          'Privacy Policy',
                                          style: const TextStyle(
                                            fontFamily: mainFontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.02,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          gradientType: GradientType.linear,
                                          gradientDirection:
                                              GradientDirection.ltr,
                                          colors: const [
                                            purpleColor2,
                                            purpleColor1
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        ' . ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: mainFontFamily,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.02,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _launchURL(
                                            'https://www.oneplay.in/tnc.html'),
                                        child: GradientText(
                                          'Terms & Conditions',
                                          style: const TextStyle(
                                            fontFamily: mainFontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.02,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          gradientType: GradientType.linear,
                                          gradientDirection:
                                              GradientDirection.ltr,
                                          colors: const [
                                            purpleColor2,
                                            purpleColor1
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
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
      String userDetail = jsonEncode(userModel);

      SharedPrefService.storeUserDetail(userDetail);
    });
  }

  _loginLogEvent({
    required String userId,
    required String partnerId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    analytics.logEvent(
      name: loginEvent,
      parameters: {
        "user_id": userId,
        "partner_id": partnerId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      },
    );
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

          _loginLogEvent(
            userId: userModel!.id.toString(),
            partnerId: userModel!.partnerId.toString(),
            firstName: userModel!.firstName.toString(),
            lastName: userModel!.lastName.toString(),
            email: userModel!.email.toString(),
            phone: userModel!.phone.toString(),
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

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
