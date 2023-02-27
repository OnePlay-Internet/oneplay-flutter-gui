import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/app.dart';
import 'package:oneplay_flutter_gui/app/app_widget.dart';
import 'package:oneplay_flutter_gui/app/services/shared_pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

int selectedIndex = 0;
int previousIndex = 0;
ValueNotifier<int> navigateIdx = ValueNotifier<int>(0);
