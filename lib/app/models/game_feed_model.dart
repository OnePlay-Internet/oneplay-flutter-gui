import 'package:json_annotation/json_annotation.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';

part 'game_feed_model.g.dart';

@JsonSerializable()
class GameFeedModel {
  String title;

  @JsonKey(name: "results")
  List<ShortGameModel> games;

  GameFeedModel({required this.title, required this.games});

  factory GameFeedModel.fromJson(Map<String, dynamic> json) =>
      _$GameFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameFeedModelToJson(this);
}
