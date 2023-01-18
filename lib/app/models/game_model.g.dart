// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseStore _$PurchaseStoreFromJson(Map<String, dynamic> json) =>
    PurchaseStore(
      name: json['name'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$PurchaseStoreToJson(PurchaseStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
    };

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String,
      oneplayId: json['oplay_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      playTime: json['play_time'] as int,
      releaseDate: GameModel._dateFromString(json['release_date'] as String),
      posterImg: json['poster_image'] as String,
      bgImage: json['background_image'] as String,
      textBgImage: json['text_background_image'] as String,
      textLogo: json['text_logo'] as String,
      trailerVideo: json['trailer_video'] as String?,
      video: GameModel._stringFromList(json['videos'] as List),
      rating: (json['rating'] as num).toDouble(),
      isFree: GameModel._boolFromString(json['is_free'] as String),
      popularityScore: (json['popularity_score'] as num).toDouble(),
      metacriticScore: json['metacritic_score'] as int?,
      officialWebsite: json['official_website'] as String?,
      ageRating: json['age_rating'] as String,
      rawgId: json['rawg_id'] as String,
      cheapsharkId: json['cheapshark_id'] as String?,
      isReleased: GameModel._boolFromString(json['is_released'] as String),
      status: json['status'] as String,
      isCategorized:
          GameModel._boolFromString(json['is_categorized'] as String),
      createdAt: GameModel._dateFromSec(json['created_at'] as int),
      updatedAt: GameModel._dateFromSec(json['updated_at'] as int),
      genreMappings: (json['genre_mappings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      platformsMapping: (json['platforms_mappings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      developer:
          (json['developer'] as List<dynamic>).map((e) => e as String).toList(),
      publisher:
          (json['publisher'] as List<dynamic>).map((e) => e as String).toList(),
      storesMapping: (json['stores_mappings'] as List<dynamic>)
          .map((e) => PurchaseStore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'oplay_id': instance.oneplayId,
      'title': instance.title,
      'description': instance.description,
      'play_time': instance.playTime,
      'release_date': GameModel._dateToString(instance.releaseDate),
      'poster_image': instance.posterImg,
      'background_image': instance.bgImage,
      'text_background_image': instance.textBgImage,
      'text_logo': instance.textLogo,
      'trailer_video': instance.trailerVideo,
      'videos': GameModel._stringToList(instance.video),
      'rating': instance.rating,
      'is_free': GameModel._boolToString(instance.isFree),
      'popularity_score': instance.popularityScore,
      'metacritic_score': instance.metacriticScore,
      'official_website': instance.officialWebsite,
      'age_rating': instance.ageRating,
      'rawg_id': instance.rawgId,
      'cheapshark_id': instance.cheapsharkId,
      'is_released': GameModel._boolToString(instance.isReleased),
      'status': instance.status,
      'is_categorized': GameModel._boolToString(instance.isCategorized),
      'created_at': GameModel._dateToSec(instance.createdAt),
      'updated_at': GameModel._dateToSec(instance.updatedAt),
      'genre_mappings': instance.genreMappings,
      'platforms_mappings': instance.platformsMapping,
      'developer': instance.developer,
      'publisher': instance.publisher,
      'stores_mappings': instance.storesMapping,
    };

ShortGameModel _$ShortGameModelFromJson(Map<String, dynamic> json) =>
    ShortGameModel(
      oneplayId: json['oplay_id'] as String,
      title: json['title'] as String,
      releaseDate:
          ShortGameModel._dateFromString(json['release_date'] as String),
      posterImg: json['poster_image'] as String?,
      bgImage: json['background_image'] as String?,
      textBgImage: json['text_background_image'] as String?,
      textLogo: json['text_logo'] as String?,
      isFree: ShortGameModel._boolFromString(json['is_free'] as String),
      status: json['status'] as String,
      genreMappings: (json['genre_mappings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ShortGameModelToJson(ShortGameModel instance) =>
    <String, dynamic>{
      'oplay_id': instance.oneplayId,
      'title': instance.title,
      'release_date': ShortGameModel._dateToString(instance.releaseDate),
      'poster_image': instance.posterImg,
      'background_image': instance.bgImage,
      'text_background_image': instance.textBgImage,
      'text_logo': instance.textLogo,
      'is_free': ShortGameModel._boolToString(instance.isFree),
      'status': instance.status,
      'genre_mappings': instance.genreMappings,
    };
