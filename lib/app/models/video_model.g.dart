// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      id: json['_id'] as String,
      gameId: json['game_id'] as String,
      gameName: json['game_name'] as String,
      source: json['source'] as String,
      isEdited: json['is_edited'] as bool? ?? false,
      status: json['status'] as String,
      addedAt: VideoModel._dateFromSec(json['added_at'] as int),
      updatedAt: VideoModel._dateFromSec(json['updated_at'] as int),
      contentId: json['content_id'] as String,
      sourceViews: json['source_views'] as String,
      duration: json['duration'] as String,
      title: json['title'] as String,
      sourceLink: json['source_link'] as String,
      description: json['description'] as String,
      creatorId: json['creator_id'] as String,
      creatorLink: json['creator_link'] as String,
      creatorName: json['creator_name'] as String,
      creatorThumbnail: json['creator_thumbnail'] as String,
      thumbnail: json['thumbnail'] as String,
      isLive: json['is_live'] as bool,
      contentType: json['content_type'] as String,
      isAgeRestricted: json['is_age_restricted'] as bool,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'game_id': instance.gameId,
      'game_name': instance.gameName,
      'source': instance.source,
      'is_edited': instance.isEdited,
      'status': instance.status,
      'added_at': VideoModel._dateToSec(instance.addedAt),
      'updated_at': VideoModel._dateToSec(instance.updatedAt),
      'content_id': instance.contentId,
      'source_views': instance.sourceViews,
      'duration': instance.duration,
      'title': instance.title,
      'source_link': instance.sourceLink,
      'description': instance.description,
      'creator_id': instance.creatorId,
      'creator_link': instance.creatorLink,
      'creator_name': instance.creatorName,
      'creator_thumbnail': instance.creatorThumbnail,
      'thumbnail': instance.thumbnail,
      'is_live': instance.isLive,
      'content_type': instance.contentType,
      'is_age_restricted': instance.isAgeRestricted,
    };
