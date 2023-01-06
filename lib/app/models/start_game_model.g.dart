// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameData _$GameDataFromJson(Map<String, dynamic> json) => GameData(
      id: json['game_id'] as String,
      name: json['game_name'] as String,
    );

Map<String, dynamic> _$GameDataToJson(GameData instance) => <String, dynamic>{
      'game_id': instance.id,
      'game_name': instance.name,
    };

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
      id: json['id'] as String,
      launchedAt: SessionData._dateFromSec(json['launched_at'] as int),
    );

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'launched_at': SessionData._dateToSec(instance.launchedAt),
    };

StartGameModel _$StartGameModelFromJson(Map<String, dynamic> json) =>
    StartGameModel(
      apiAction:
          StartGameModel._apiActionFromString(json['api_action'] as String?),
      game: json['game'] == null
          ? null
          : GameData.fromJson(json['game'] as Map<String, dynamic>),
      session: json['session'] == null
          ? null
          : SessionData.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StartGameModelToJson(StartGameModel instance) =>
    <String, dynamic>{
      'api_action': StartGameModel._apiActionToString(instance.apiAction),
      'game': instance.game,
      'session': instance.session,
    };

StartGameResponse _$StartGameResponseFromJson(Map<String, dynamic> json) =>
    StartGameResponse(
      code: json['code'] as int,
      data: StartGameModel.fromJson(json['data'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$StartGameResponseToJson(StartGameResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
    };
