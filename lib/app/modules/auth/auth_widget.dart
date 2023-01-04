import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const RouterOutlet(),
    );
  }
}
