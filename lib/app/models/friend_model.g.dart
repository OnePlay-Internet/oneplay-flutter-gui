// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) => FriendModel(
      id: json['id'] as String,
      status: FriendModel._statusFromString(json['status'] as String),
      acceptedAt: FriendModel._dateFromString(json['accepted_at'] as String?),
      createdAt: FriendModel._dateFromString2(json['created_at'] as String),
      updatedAt: FriendModel._dateFromString2(json['updated_at'] as String),
      isOnline: json['isOnline'] as bool,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      lastLogin:
          FriendModel._dateFromString(json['last_login_timestamp'] as String?),
      profileImage: json['profile_image'] as String?,
      userId: json['user_id'] as String,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$FriendModelToJson(FriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': FriendModel._statusToString(instance.status),
      'accepted_at': FriendModel._dateToString(instance.acceptedAt),
      'created_at': FriendModel._dateToString2(instance.createdAt),
      'updated_at': FriendModel._dateToString2(instance.updatedAt),
      'isOnline': instance.isOnline,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'last_login_timestamp': FriendModel._dateToString(instance.lastLogin),
      'profile_image': instance.profileImage,
      'user_id': instance.userId,
      'username': instance.username,
    };
