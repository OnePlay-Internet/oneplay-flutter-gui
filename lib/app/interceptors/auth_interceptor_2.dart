import 'package:dio/dio.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class AuthInterceptor2 extends Interceptor {
  final AuthService _authService;

  AuthInterceptor2(this._authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authService.userIdToken != null) {
      FormData formData = options.data ?? FormData();
      formData.fields.add(MapEntry(
        'user_id',
        _authService.userIdToken?.userId ?? '',
      ));
      formData.fields.add(MapEntry(
        'session_token',
        _authService.userIdToken?.token ?? '',
      ));
      options.data = formData;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String? message = err.response?.data?['msg'];

    if (message != null && message != '') {
      err.error = {'message': message};
    } else {
      err.error = {'message': 'Server is not responding'};
    }
    super.onError(err, handler);
  }
}
