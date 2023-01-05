import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/theme/style.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/textfield/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

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
        child: Column(
          children: [
            headTitle(),
            const SizedBox(height: 40),
            customTextField(labelText: 'Email / Phone', hintText: 'Email', textCtrler: idCtrler),
            const SizedBox(height: 40),
            customTextField(labelText: 'Password', hintText: '', textCtrler: pwdCtrler, textInputType: TextInputType.visiblePassword)
          ],
        ),
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
