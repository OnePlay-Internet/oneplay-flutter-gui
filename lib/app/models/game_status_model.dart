import 'package:json_annotation/json_annotation.dart';

part 'game_status_model.g.dart';

@JsonSerializable()
class GameStatusModel {
  @JsonKey(name: 'game_id')
  String? gameId;

  @JsonKey(name: 'game_name')
  String? gameName;

  @JsonKey(name: 'is_running')
  bool? isRunning;

  @JsonKey(name: 'is_user_connected')
  bool? isUserConnected;

  @JsonKey(name: 'session_id')
  String? sessionId;

  GameStatusModel({
    this.gameId,
    this.gameName,
    this.isRunning,
    this.isUserConnected,
    this.sessionId,
  });

  factory GameStatusModel.fromJson(Map<String, dynamic> json) =>
      _$GameStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameStatusModelToJson(this);
}

@JsonSerializable()
class GameStatusResponse {
  GameStatusModel data;

  GameStatusResponse({required this.data});

  factory GameStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$GameStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GameStatusResponseToJson(this);
}
