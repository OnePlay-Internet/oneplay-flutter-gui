// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameFeedModel _$GameFeedModelFromJson(Map<String, dynamic> json) =>
    GameFeedModel(
      title: json['title'] as String,
      games: (json['results'] as List<dynamic>)
          .map((e) => ShortGameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameFeedModelToJson(GameFeedModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'results': instance.games,
    };
