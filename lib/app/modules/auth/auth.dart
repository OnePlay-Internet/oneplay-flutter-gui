import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/modules/auth/auth_widget.dart';
import 'package:oneplay_flutter_gui/app/pages/login.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

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
