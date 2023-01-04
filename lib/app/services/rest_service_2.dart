import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor_2.dart';
import 'package:oneplay_flutter_gui/app/models/game_status_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class RestService2 {
  final Dio _dio;

  RestService2(final AuthService authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.env['CLIENT_API_BASE_URL'] ?? '',
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(AuthInterceptor2(authService));

  Future<GameStatusModel> getGameStatus() async {
    Response res = await _dio.post('/get_any_active_session_status');

    GameStatusResponse gameStatusResponse =
        GameStatusResponse.fromJson(res.data);

    return gameStatusResponse.data;
  }
}
