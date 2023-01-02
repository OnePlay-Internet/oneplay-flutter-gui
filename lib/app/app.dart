import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/guards/auth_guard.dart';
import 'package:oneplay_flutter_gui/app/guards/login_guard.dart';
import 'package:oneplay_flutter_gui/app/modules/admin/admin.dart';
import 'package:oneplay_flutter_gui/app/modules/auth/auth.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AdminModule(), guards: [AuthGuard()]),
        ModuleRoute('/auth', module: AuthModule(), guards: [LoginGuard()]),
      ];
}
