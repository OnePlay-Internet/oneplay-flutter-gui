import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService;

  AuthInterceptor(this._authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authService.sessionToken != null) {
      options.headers['session_token'] = _authService.sessionToken;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String? message = err.response?.data?['message'];
    if (message != null || message != '') {
      err.error = {'message': message};
    } else {
      err.error = {'message': 'Something went wrong'};
    }
    if (err.response?.statusCode == 401) {
      _authService.logout();
      Modular.to.navigate('/auth/login');
    }
    super.onError(err, handler);
  }
}
