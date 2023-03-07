import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/modules/auth/auth_widget.dart';
import 'package:oneplay_flutter_gui/app/pages/login.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';

import '../../pages/Forgot_Password_Screen/forgot_password_screen.dart';
import '../../pages/Login_Screen/login_screen.dart';
import '../../pages/Signup_Screen/signup_screen.dart';
import '../../pages/email_send_success.dart';
import '../../pages/forgot_password.dart';
import '../../pages/signup.dart';

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
            ChildRoute(
              '/login',
              child: (context, args) => const LoginScreen(),
            ),
            ChildRoute(
              '/forgotPass',
              child: (context, args) => const ForgotPasswordScreen(),
            ),
            ChildRoute(
              '/sentSuccess',
              child: (context, args) => const EmailSentSuccess(),
            ),
            ChildRoute(
              '/signup',
              child: (context, args) => const SignupScreen(),
            ),
          ],
        ),
      ];
}
