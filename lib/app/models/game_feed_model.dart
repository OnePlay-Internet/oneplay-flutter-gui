import 'package:json_annotation/json_annotation.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';

part 'game_feed_model.g.dart';

@JsonSerializable()
class GameFeedModel {
  String title;

  @JsonKey(name: "results")
  List<FeedGameModel> games;

  GameFeedModel({required this.title, required this.games});

  factory GameFeedModel.fromJson(Map<String, dynamic> json) =>
      _$GameFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameFeedModelToJson(this);
}

@JsonSerializable()
class FeedGameModel {
  @JsonKey(name: 'oplay_id')
  String oneplayId;

  String title;

  @JsonKey(
    name: 'release_date',
    fromJson: _dateFromString,
    toJson: _dateToString,
  )
  DateTime releaseDate;

  @JsonKey(name: 'poster_image')
  String? posterImg;

  @JsonKey(name: 'background_image')
  String? bgImage;

  @JsonKey(name: 'text_background_image')
  String? textBgImage;

  @JsonKey(name: 'text_logo')
  String? textLogo;

  @JsonKey(
    name: 'is_free',
    fromJson: _boolFromString,
    toJson: _boolToString,
  )
  bool isFree;

  String status;

  @JsonKey(name: 'genre_mappings')
  List<String> genreMappings;

  FeedGameModel({
    required this.oneplayId,
    required this.title,
    required this.releaseDate,
    required this.posterImg,
    required this.bgImage,
    required this.textBgImage,
    required this.textLogo,
    required this.isFree,
    required this.status,
    required this.genreMappings,
  });

    factory FeedGameModel.fromJson(Map<String, dynamic> json) =>
      _$FeedGameModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedGameModelToJson(this);

  static bool _boolFromString(String value) => value == 'true';

  static String _boolToString(bool value) => value ? 'true' : 'false';

  static DateTime _dateFromString(String value) => DateTime.parse(value);

  static String _dateToString(DateTime value) =>
      value.toString().split(' ').first;
}
