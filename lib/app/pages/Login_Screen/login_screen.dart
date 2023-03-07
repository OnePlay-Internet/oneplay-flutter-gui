import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validators/validators.dart';

import '../../../main.dart';
import '../../common/common.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/rest_service.dart';
import '../../services/shared_pref_service.dart';
import '../../widgets/gamepad_pop/gamepad_pop.dart';
import '../../widgets/popup/popup_success.dart';
import '../../widgets/popup/steps_alert_dialog.dart';
import 'Components.dart/landscape_login_ui.dart';
import 'Components.dart/portrait_login_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final RestService restService = Modular.get<RestService>();
  final AuthService authService = Modular.get<AuthService>();

  String email = "";
  String password = "";
  String errorEmail = "";
  String errorPassword = "";

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
          // final isPortrait = orientation == Orientation.portrait;
          // print('***** Portrait: $isPortrait *****');
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 5
                  : 8;

          return isPortrait == 5
              ? PortraitLoginUi(
                  isPortrait: isPortrait,
                  emailController: TextEditingController(text: email),
                  passworController: TextEditingController(text: password),
                  errorEmail: errorEmail,
                  errorPassword: errorPassword,
                  isLoading: loading,
                  onChangedEmail: (value) {
                    email = value;
                  },
                  onChangedPassword: (value) {
                    password = value;
                  },
                  onTapForgotPassword: () {
                    Modular.to.pushNamed('/auth/forgotPass');
                  },
                  onTapSubmit: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (!isEmail(email)) {
                      setState(() => errorEmail = "Invalid email address");
                      return;
                    }
                    if (email.isEmpty) {
                      setState(() => errorEmail = "Enter your email");
                      return;
                    }
                    if (password.isEmpty) {
                      setState(() => errorPassword = "Enter your password");
                      return;
                    }

                    login(email.trim(), password.trim());
                  },
                  onTapCreateAccount: () {
                    Modular.to.pushNamed('/auth/signup');
                  },
                )
              : LandscapeLoginUi(
                  isPortrait: isPortrait,
                  emailController: TextEditingController(text: email),
                  passworController: TextEditingController(text: password),
                  errorEmail: errorEmail,
                  errorPassword: errorPassword,
                  isLoading: loading,
                  onChangedEmail: (value) {
                    email = value;
                  },
                  onChangedPassword: (value) {
                    password = value;
                  },
                  onTapForgotPassword: () {
                    Modular.to.pushNamed('/auth/forgotPass');
                  },
                  onTapSubmit: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (!isEmail(email)) {
                      setState(() => errorEmail = "Invalid email address");
                      return;
                    }
                    if (email.isEmpty) {
                      setState(() => errorEmail = "Enter your email");
                      return;
                    }
                    if (password.isEmpty) {
                      setState(() => errorPassword = "Enter your password");
                      return;
                    }

                    login(email.trim(), password.trim());
                  },
                  onTapCreateAccount: () {
                    Modular.to.pushNamed('/auth/signup');
                  },
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
}
