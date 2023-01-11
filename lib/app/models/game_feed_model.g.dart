// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameFeedModel _$GameFeedModelFromJson(Map<String, dynamic> json) =>
    GameFeedModel(
      title: json['title'] as String,
      games: (json['results'] as List<dynamic>)
          .map((e) => FeedGameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameFeedModelToJson(GameFeedModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'results': instance.games,
    };

FeedGameModel _$FeedGameModelFromJson(Map<String, dynamic> json) =>
    FeedGameModel(
      oneplayId: json['oplay_id'] as String,
      title: json['title'] as String,
      releaseDate:
          FeedGameModel._dateFromString(json['release_date'] as String),
      posterImg: json['poster_image'] as String?,
      bgImage: json['background_image'] as String?,
      textBgImage: json['text_background_image'] as String?,
      textLogo: json['text_logo'] as String?,
      isFree: FeedGameModel._boolFromString(json['is_free'] as String),
      status: json['status'] as String,
      genreMappings: (json['genre_mappings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FeedGameModelToJson(FeedGameModel instance) =>
    <String, dynamic>{
      'oplay_id': instance.oneplayId,
      'title': instance.title,
      'release_date': FeedGameModel._dateToString(instance.releaseDate),
      'poster_image': instance.posterImg,
      'background_image': instance.bgImage,
      'text_background_image': instance.textBgImage,
      'text_logo': instance.textLogo,
      'is_free': FeedGameModel._boolToString(instance.isFree),
      'status': instance.status,
      'genre_mappings': instance.genreMappings,
    };
