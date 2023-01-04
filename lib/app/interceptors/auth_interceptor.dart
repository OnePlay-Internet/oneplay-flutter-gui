import 'package:dio/dio.dart';
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
    print(err.response?.statusCode);
    super.onError(err, handler);
  }
}
