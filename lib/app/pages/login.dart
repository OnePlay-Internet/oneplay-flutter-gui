import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/common_divider.dart';
import 'package:oneplay_flutter_gui/app/widgets/footer/authFooter.dart';
import 'package:oneplay_flutter_gui/app/widgets/textfield/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:validators/validators.dart';

import '../widgets/popup/popup_success.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              description: 'You will be redirect to Feed Page'),
          barrierDismissible: false);
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() => loading = false);
        Modular.to.navigate('/feeds');
      });
    } on DioError catch (e) {
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
              description: e.error['message'],
            );
          },
          barrierDismissible: false);
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
              hintText: '',
              textCtrler: pwdCtrler,
              textInputType: TextInputType.visiblePassword,
              errorText: errorPwd,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [savePwd(), forgotPwd()],
              ),
            ),
            loginBtn(context, () {
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
            }),
            createNewAccount(),
            commonDividerWidget(),
            needHelpWidget(),
            authFooterWidget()
          ]),
        ),
      ),
    ));
  }

  Padding createNewAccount() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Don\'t have an account? ',
            style: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor),
          ),
          GradientText(
            'Create a New',
            style: const TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02),
            gradientType: GradientType.linear,
            gradientDirection: GradientDirection.ltr,
            colors: const [purpleColor2, purpleColor1],
          ),
        ]));
  }

  Padding loginBtn(BuildContext context, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft,
                  colors: [pinkColor1, blueColor1])),
          child: Center(
              child: loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            )),
                        SizedBox(width: 15),
                        Text(
                          'Logging you in...',
                          style: TextStyle(
                              fontFamily: mainFontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 0.02),
                        )
                      ],
                    )
                  : const Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: mainFontFamily,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.02),
                    )),
        ),
      ),
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
          color: textPrimaryColor),
    );
  }

  Row savePwd() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
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
          'Remember me',
          style: TextStyle(
              fontFamily: mainFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.02,
              color: textSecondaryColor),
        )
      ],
    );
  }

  Container headTitle() {
    return Container(
        alignment: Alignment.center,
        child: const Text('Log in to your account',
            style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.02,
                color: Colors.white,
                fontSize: 30)));
  }
}
