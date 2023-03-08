import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/gamepad_model.dart';
import 'package:oneplay_flutter_gui/app/services/gamepad_service.dart';

class AppWidget extends StatelessWidget {
  final GamepadService gamepadService;

  const AppWidget(this.gamepadService, {super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/feeds');

    MethodChannel channel = const MethodChannel('flutter-gui');
    channel.setMethodCallHandler((call) => _handleMessage(call));
    channel.invokeMethod('flutterInitFinished');

    return MaterialApp.router(
      title: 'Oneplay',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: mainFontFamily,
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    switch (call.method) {
      case 'on_controller_connected_event':
        print('On Connect controller');
        var gamepad = GamepadModel.fromJson(
          TextUtils.perseJSON(call.arguments),
        );
        gamepadService.connect(gamepad);
        break;
      case 'on_controller_disconnected_event':
        print('On Disconnect Controller');
        var gamepad = GamepadModel.fromJson(
          TextUtils.perseJSON(call.arguments),
        );
        gamepadService.disconnect(gamepad);
        break;
    }
  }
}
