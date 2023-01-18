import 'package:json_annotation/json_annotation.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchGamesModel {
  String keyword;

  String keywordHash;

  List<ShortGameModel> results;

  SearchGamesModel({
    required this.keyword,
    required this.keywordHash,
    required this.results,
  });

  factory SearchGamesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchGamesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGamesModelToJson(this);
}
