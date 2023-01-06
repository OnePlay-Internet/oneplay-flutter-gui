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
          loginBtn(context),
          createNewAccount(),
          commonDividerWidget(),
          needHelpWidget(),
          authFooterWidget()
        ]),
      ),
    ));

    // return Container(
    //   margin: EdgeInsets.only(
    //     left: 40,
    //     right: 40,
    //     top: MediaQuery.of(context).size.height * 0.2,
    //   ),
    //   height: MediaQuery.of(context).size.height * 0.6,
    //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: const Color.fromRGBO(168, 157, 237, 1)),
    //   ),
    //   child: Form(
    //     key: _formKey,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           TextFormField(
    //             controller: idTextController,
    //             decoration: const InputDecoration(
    //               icon: Icon(Icons.person),
    //               hintText: 'Enter your phone or email',
    //               labelText: 'Id',
    //             ),
    //             onSaved: (value) => idTextController.text = value ?? '',
    //           ),
    //           const SizedBox(height: 24),
    //           TextFormField(
    //             controller: passwordTextController,
    //             decoration: const InputDecoration(
    //               icon: Icon(Icons.key),
    //               hintText: 'Enter your password',
    //               labelText: 'Password',
    //             ),
    //             onSaved: (value) => passwordTextController.text = value ?? '',
    //           ),
    //           const SizedBox(height: 24),
    //           OutlinedButton(
    //             onPressed: loading
    //                 ? null
    //                 : () => login(
    //                       idTextController.text.trim(),
    //                       passwordTextController.text.trim(),
    //                     ),
    //             child: const Text('Login'),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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

  Padding loginBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [pinkColor1, blueColor1])),
        child: const Center(
            child: Text(
          'Log in',
          style: TextStyle(
              fontFamily: mainFontFamily,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.02),
        )),
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
