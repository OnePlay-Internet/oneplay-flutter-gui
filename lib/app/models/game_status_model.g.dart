// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStatusModel _$GameStatusModelFromJson(Map<String, dynamic> json) =>
    GameStatusModel(
      gameId: json['game_id'] as String?,
      gameName: json['game_name'] as String?,
      isRunning: json['is_running'] as bool?,
      isUserConnected: json['is_user_connected'] as bool?,
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$GameStatusModelToJson(GameStatusModel instance) =>
    <String, dynamic>{
      'game_id': instance.gameId,
      'game_name': instance.gameName,
      'is_running': instance.isRunning,
      'is_user_connected': instance.isUserConnected,
      'session_id': instance.sessionId,
    };

GameStatusResponse _$GameStatusResponseFromJson(Map<String, dynamic> json) =>
    GameStatusResponse(
      data: GameStatusModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameStatusResponseToJson(GameStatusResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
