import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class RestService {
  final Dio _dio;
  final AuthService _authService;

  RestService(this._authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.env['API_BASE_URL'] ?? '',
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(AuthInterceptor(_authService));

  Future<UserModel> getProfile() async {
    Response userData = await _dio.get('/accounts/profile');

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<String> login({
    required String id,
    required String password,
  }) async {
    Response loginData = await _dio.post(
      '/accounts/login',
      data: {
        'id': id,
        'password': password,
        'device': 'mobile',
      },
    );

    return loginData.data['session_token'];
  }
}
