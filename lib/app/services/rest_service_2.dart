import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor_2.dart';
import 'package:oneplay_flutter_gui/app/models/client_token_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_status_model.dart';
import 'package:oneplay_flutter_gui/app/models/start_game_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import '../models/game_setting.dart';

class RestService2 {
  final Dio _dio;

  RestService2(final AuthService authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: CLIENT_API_BASE_URL,
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(
            AuthInterceptor2(authService),
          );

  Future<GameStatusModel> getGameStatus() async {
    Response res = await _dio.post('/get_any_active_session_status');

    GameStatusResponse gameStatusResponse =
        GameStatusResponse.fromJson(res.data);

    return gameStatusResponse.data;
  }

  Future<StartGameResponse> startGame(
    String gameId,
    GameSetting setting,
  ) async {
    const jsonEncoder = JsonEncoder();
    FormData data = FormData.fromMap({
      'game_id': gameId,
      'launch_payload': jsonEncoder.convert({
        "resolution": setting.resolution,
        "is_vsync_enabled": setting.is_vsync_enabled,
        "fps": setting.fps.toString(),
        "bitrate": setting.bitrate!.toInt(),
        "show_stats": setting.show_stats,
        "fullscreen": setting.fullscreen,
        "onscreen_controls": setting.onscreen_controls,
        "audio_type": setting.audio_type,
        "stream_codec": setting.stream_codec,
        "video_decoder_selection": setting.video_decoder_selection,
      })
    }, ListFormat.multiCompatible);

    Response res = await _dio.post('/start_game', data: data);

    return StartGameResponse.fromJson(res.data);
  }

  Future<ClientTokenModel> getClientToken(String sessionId) async {
    FormData data = FormData.fromMap({'session_id': sessionId});

    Response res = await _dio.post('/get_session', data: data);

    return ClientTokenResponse.fromJson(res.data).data;
  }

  Future<void> terminateSession(String sessionId) async {
    FormData data = FormData.fromMap({'session_id': sessionId});

    await _dio.post('/terminate_stream', data: data);
  }

  Future<String> deleteSessionData() async {
    Response res = await _dio.post("/delete_user_data");
    return res.data['status'];
  }
}
