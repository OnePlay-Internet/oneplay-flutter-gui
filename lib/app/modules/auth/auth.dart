import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/modules/auth/auth_widget.dart';
import 'package:oneplay_flutter_gui/app/pages/login.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthService()),
        Bind((i) => RestService(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const AuthWidget(),
          children: [
            ChildRoute('/login', child: (context, args) => const Login()),
          ],
        ),
      ];
}
