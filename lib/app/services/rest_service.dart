import 'package:dio/dio.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class RestService {
  final Dio _dio;

  RestService(final AuthService authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: API_BASE_URL,
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(AuthInterceptor(authService));

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

  Future<List<String>> getWishlist() async {
    Response res = await _dio.get('/accounts/wishlist');

    return (res.data as List<dynamic>).map((e) => e as String).toList();
  }

  Future<GameModel> getGameDetails(String id) async {
    Response res = await _dio.get('/games/$id/info');

    return GameModel.fromJson(res.data);
  }

  Future<List<GameFeedModel>> getHomeFeed() async {
    Response res = await _dio.get('/games/feed/personalized', queryParameters: {
      'textBackground': "280x170",
      'textLogo': "400x320",
      'poster': "528x704",
    });

    var data = (res.data as List<dynamic>).map((d) => GameFeedModel.fromJson(d)).toList();

    return data;
  }
}
