import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';

class RestService {
  final Dio _dio;

  RestService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.env['API_BASE_URL'] ?? '',
            connectTimeout: 5000,
            receiveTimeout: 5000,
          ),
        )..interceptors.add(AuthInterceptor());

  Future<UserModel> getProfile() async {
    Response userData = await _dio.get('/accounts/profile');

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }
}
