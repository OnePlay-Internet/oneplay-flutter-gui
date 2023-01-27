import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'game_name')
  String gameName;

  String source;

  @JsonKey(name: 'is_edited')
  bool isEdited;

  String status;

  @JsonKey(
    name: 'added_at',
    fromJson: _dateFromSec,
    toJson: _dateToSec,
  )
  DateTime addedAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _dateFromSec,
    toJson: _dateToSec,
  )
  DateTime updatedAt;

  @JsonKey(name: 'content_id')
  String contentId;

  @JsonKey(name: 'source_views')
  String sourceViews;

  String duration;

  String title;

  @JsonKey(name: 'source_link')
  String sourceLink;

  String description;

  @JsonKey(name: 'creator_id')
  String creatorId;

  @JsonKey(name: 'creator_link')
  String creatorLink;

  @JsonKey(name: 'creator_name')
  String creatorName;

  @JsonKey(name: 'creator_thumbnail')
  String creatorThumbnail;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'is_live')
  bool isLive;

  @JsonKey(name: 'content_type')
  String contentType;

  @JsonKey(name: 'is_age_restricted')
  bool isAgeRestricted;

  VideoModel(
      {required this.id,
      required this.gameId,
      required this.gameName,
      required this.source,
      this.isEdited = false,
      required this.status,
      required this.addedAt,
      required this.updatedAt,
      required this.contentId,
      required this.sourceViews,
      required this.duration,
      required this.title,
      required this.sourceLink,
      required this.description,
      required this.creatorId,
      required this.creatorLink,
      required this.creatorName,
      required this.creatorThumbnail,
      required this.thumbnail,
      required this.isLive,
      required this.contentType,
      required this.isAgeRestricted});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  static bool _boolFromString(String value) => value == 'true';

  static String _boolToString(bool value) => value ? 'true' : 'false';

  static DateTime _dateFromSec(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000);

  static int _dateToSec(DateTime value) =>
      (value.millisecondsSinceEpoch / 1000).floor();
}

        // "_id": "63c935afe9eb5b6cdd84db44",
        // "game_id": "28428948074d7e424071f3a7209523bbd22d8d8e1d59d952ba590553b61fc358",
        // "game_name": "Control",
        // "source": "youtube",
        // "is_edited": false,
        // "status": "live",
        // "added_at": 1674130863,
        // "updated_at": 1674130998,
        // "content_id": "ltCjUTVSbsQ",
        // "source_views": "",
        // "duration": "56:45",
        // "title": "CONTROL Walkthrough Gameplay Part 1 - INTRO (FULL GAME)",
        // "source_link": "https://www.youtube.com/watch?v=ltCjUTVSbsQ",
        // "description": "Control Walkthrough",
        // "creator_id": "UCpqXJOEqGS-TCnazcHCo0rA",
        // "creator_link": "https://www.youtube.com/channel/UCpqXJOEqGS-TCnazcHCo0rA",
        // "creator_name": "theRadBrad",
        // "creator_thumbnail": "https://yt3.ggpht.com/ytc/AMLnZu_2_BRu0Tvluguc2EWjA-pgkjdH3IXBelsHDjQfMA=s68-c-k-c0x00ffffff-no-rj",
        // "thumbnail": "https://i.ytimg.com/vi/ltCjUTVSbsQ/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB9jOUPTsvUKf26hAe5TZpxHb0FgA",
        // "video_playback_meta": {
        //     "": ""
        // },
        // "is_live": false,
        // "content_type": "catch-up",
        // "is_age_restricted": false