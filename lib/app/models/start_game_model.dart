import 'package:json_annotation/json_annotation.dart';

part 'start_game_model.g.dart';

enum ApiAction {
  callTerminate,
  callSession,
}

@JsonSerializable()
class GameData {
  @JsonKey(name: 'game_id')
  String id;

  @JsonKey(name: 'game_name')
  String name;

  GameData({
    required this.id,
    required this.name,
  });

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}

@JsonSerializable()
class SessionData {
  String id;

  @JsonKey(
    name: 'launched_at',
    fromJson: _dateFromSec,
    toJson: _dateToSec,
  )
  DateTime launchedAt;

  SessionData({
    required this.id,
    required this.launchedAt,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);

  static DateTime _dateFromSec(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000);

  static int _dateToSec(DateTime value) =>
      (value.millisecondsSinceEpoch / 1000).floor();
}

@JsonSerializable()
class StartGameModel {
  @JsonKey(
    name: 'api_action',
    fromJson: _apiActionFromString,
    toJson: _apiActionToString,
  )
  ApiAction? apiAction;

  GameData? game;

  SessionData? session;

  StartGameModel({
    this.apiAction,
    this.game,
    this.session,
  });

  factory StartGameModel.fromJson(Map<String, dynamic> json) =>
      _$StartGameModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartGameModelToJson(this);

  static ApiAction? _apiActionFromString(String? value) {
    switch (value) {
      case 'call_terminate':
        return ApiAction.callTerminate;
      case 'call_session':
        return ApiAction.callSession;
      default:
        return null;
    }
  }

  static String? _apiActionToString(ApiAction? value) {
    switch (value) {
      case ApiAction.callTerminate:
        return 'call_terminate';
      case ApiAction.callSession:
        return 'call_session';
      default:
        return null;
    }
  }
}

@JsonSerializable()
class StartGameResponse {
  int code;

  StartGameModel data;

  String msg;

  StartGameResponse({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory StartGameResponse.fromJson(Map<String, dynamic> json) =>
      _$StartGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StartGameResponseToJson(this);
}
