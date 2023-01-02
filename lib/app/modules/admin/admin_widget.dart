import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminWidget extends StatelessWidget {
  const AdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oneplay')),
      body: const RouterOutlet(),
    );
  }
}
