import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class LoginGuard extends RouteGuard {
  LoginGuard() : super(redirectTo: '/feeds');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    var token = Modular.get<AuthService>().sessionToken;
    print('Login guard : $token');
    return token == null;
  }
}
