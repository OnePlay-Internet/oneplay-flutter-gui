import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/app.dart';
import 'package:oneplay_flutter_gui/app/app_widget.dart';

void main() => runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
