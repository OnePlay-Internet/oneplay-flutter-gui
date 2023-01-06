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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isSavePwd = false;

  login(String id, String password) async {
    final RestService restService = Modular.get<RestService>();
    final AuthService authService = Modular.get<AuthService>();

    setState(() => loading = true);

    String token = await restService.login(id: id, password: password);
    await authService.login(token);

    setState(() => loading = false);
    Modular.to.navigate('/feeds');
  }

  @override
  Widget build(BuildContext context) {
    final idCtrler = TextEditingController();
    final pwdCtrler = TextEditingController();

    return SafeArea(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            headTitle(),
            const SizedBox(height: 40),
            customTextField(
                labelText: 'Email / Phone',
                hintText: 'Email Address',
                textCtrler: idCtrler),
            const SizedBox(height: 40),
            customTextField(
                labelText: 'Password',
                hintText: '',
                textCtrler: pwdCtrler,
                textInputType: TextInputType.visiblePassword),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [savePwd(), forgotPwd()],
              ),
            ),
            loginBtn(context,
                () => login(idCtrler.text.trim(), pwdCtrler.text.trim())),
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
                color: greyColor1),
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                        SizedBox(width: 15),
                        Text(
                          'Validating....',
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
          color: greyColor2),
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
              thumbColor: greyColor2,
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
              color: greyColor1),
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
