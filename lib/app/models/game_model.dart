import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class PurchaseStore {
  String name;

  String link;

  PurchaseStore({
    required this.name,
    required this.link,
  });

  factory PurchaseStore.fromJson(Map<String, dynamic> json) =>
      _$PurchaseStoreFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseStoreToJson(this);
}

@JsonSerializable()
class GameModel {
  String id;

  @JsonKey(name: 'oplay_id')
  String oneplayId;

  String title;

  String description;

  @JsonKey(name: 'play_time')
  int playTime;

  @JsonKey(
    name: 'release_date',
    fromJson: _dateFromString,
    toJson: _dateToString,
  )
  DateTime releaseDate;

  @JsonKey(name: 'poster_image')
  String posterImg;

  @JsonKey(name: 'background_image')
  String bgImage;

  @JsonKey(name: 'text_background_image')
  String textBgImage;

  @JsonKey(name: 'text_logo')
  String textLogo;

  @JsonKey(name: 'trailer_video')
  String? trailerVideo;

  @JsonKey(
    name: 'videos',
    fromJson: _stringFromList,
    toJson: _stringToList,
  )
  String? video;

  double rating;

  @JsonKey(
    name: 'is_free',
    fromJson: _boolFromString,
    toJson: _boolToString,
  )
  bool isFree;

  @JsonKey(name: 'popularity_score')
  double popularityScore;

  @JsonKey(name: 'metacritic_score')
  int? metacriticScore;

  @JsonKey(name: 'official_website')
  String? officialWebsite;

  @JsonKey(name: 'age_rating')
  String? ageRating;

  @JsonKey(name: 'rawg_id')
  String rawgId;

  @JsonKey(name: 'cheapshark_id')
  String? cheapsharkId;

  @JsonKey(
    name: 'is_released',
    fromJson: _boolFromString,
    toJson: _boolToString,
  )
  bool isReleased;

  String status;

  @JsonKey(
    name: 'is_categorized',
    fromJson: _boolFromString,
    toJson: _boolToString,
  )
  bool isCategorized;

  @JsonKey(
    name: 'created_at',
    fromJson: _dateFromSec,
    toJson: _dateToSec,
  )
  DateTime createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _dateFromSec,
    toJson: _dateToSec,
  )
  DateTime updatedAt;

  @JsonKey(name: 'genre_mappings')
  List<String> genreMappings;

  @JsonKey(name: 'platforms_mappings')
  List<String> platformsMapping;

  List<String> developer;

  List<String> publisher;

  @JsonKey(name: 'stores_mappings')
  List<PurchaseStore> storesMapping;

  GameModel({
    required this.id,
    required this.oneplayId,
    required this.title,
    required this.description,
    required this.playTime,
    required this.releaseDate,
    required this.posterImg,
    required this.bgImage,
    required this.textBgImage,
    required this.textLogo,
    this.trailerVideo,
    this.video,
    required this.rating,
    required this.isFree,
    required this.popularityScore,
    this.metacriticScore,
    this.officialWebsite,
    this.ageRating,
    required this.rawgId,
    this.cheapsharkId,
    required this.isReleased,
    required this.status,
    required this.isCategorized,
    required this.createdAt,
    required this.updatedAt,
    required this.genreMappings,
    required this.platformsMapping,
    required this.developer,
    required this.publisher,
    required this.storesMapping,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);

  static DateTime _dateFromString(String value) => DateTime.parse(value);

  static String _dateToString(DateTime value) =>
      value.toString().split(' ').first;

  static DateTime _dateFromSec(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000);

  static int _dateToSec(DateTime value) =>
      (value.millisecondsSinceEpoch / 1000).floor();

  static bool _boolFromString(String value) => value == 'true';

  static String _boolToString(bool value) => value ? 'true' : 'false';

  static String? _stringFromList(List<dynamic> value) =>
      value.firstWhere((e) => true, orElse: () => null) as String?;

  static List<dynamic> _stringToList(String? value) =>
      value != null ? [value] : [];
}
