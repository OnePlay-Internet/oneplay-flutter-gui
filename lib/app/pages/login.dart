import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';

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
    final idTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    return Container(
      margin: EdgeInsets.only(
        left: 40,
        right: 40,
        top: MediaQuery.of(context).size.height * 0.2,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(168, 157, 237, 1)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: idTextController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your phone or email',
                  labelText: 'Id',
                ),
                onSaved: (value) => idTextController.text = value ?? '',
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: passwordTextController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                onSaved: (value) => passwordTextController.text = value ?? '',
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: loading
                    ? null
                    : () => login(
                          idTextController.text.trim(),
                          passwordTextController.text.trim(),
                        ),
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
