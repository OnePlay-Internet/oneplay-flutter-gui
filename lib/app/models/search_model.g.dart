// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchGamesModel _$SearchGamesModelFromJson(Map<String, dynamic> json) =>
    SearchGamesModel(
      keyword: json['keyword'] as String,
      keywordHash: json['keywordHash'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => ShortGameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchGamesModelToJson(SearchGamesModel instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'keywordHash': instance.keywordHash,
      'results': instance.results,
    };
