import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class LoginGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return true;
  }
}
