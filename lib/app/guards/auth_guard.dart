// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/login');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    var token = Modular.get<AuthService>().sessionToken;
    print('***** Auth guard : $token *****');

    return token != null;
  }
}
