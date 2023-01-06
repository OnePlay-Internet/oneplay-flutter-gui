// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['user_id'] as String,
      status: json['status'] as String,
      username: json['username'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      bio: json['bio'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      type: json['user_type'] as String,
      subscribedPlan: json['subscribed_plan'] as String,
      subscriptionIsActive: json['subscription_is_active'] as bool,
      isVerified: json['is_verified_profile'] as bool,
      photo: json['profile_image'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.id,
      'status': instance.status,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'bio': instance.bio,
      'email': instance.email,
      'phone': instance.phone,
      'user_type': instance.type,
      'subscribed_plan': instance.subscribedPlan,
      'subscription_is_active': instance.subscriptionIsActive,
      'is_verified_profile': instance.isVerified,
      'profile_image': instance.photo,
    };
