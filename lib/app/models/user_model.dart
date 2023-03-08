import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'user_id')
  String id;

  String status;

  String? username;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  String? bio;

  String? partnerId;

  String email;

  String phone;

  @JsonKey(name: 'user_type')
  String type;

  @JsonKey(name: 'subscribed_plan')
  dynamic subscribedPlan;

  @JsonKey(name: 'subscription_is_active')
  bool subscriptionIsActive;

  @JsonKey(name: 'is_verified_profile')
  bool isVerified;

  @JsonKey(name: 'profile_image')
  dynamic photo;

  UserModel({
    required this.id,
    required this.status,
    this.username,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.partnerId,
    required this.email,
    required this.phone,
    required this.type,
    required this.subscribedPlan,
    required this.subscriptionIsActive,
    required this.isVerified,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class ShortUserModel {
  @JsonKey(name: 'user_id')
  String id;

  String? username;

  String email;

  String phone;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  @JsonKey(name: 'profile_image')
  String? photo;

  ShortUserModel({
    required this.id,
    this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.photo,
  });

  factory ShortUserModel.fromJson(Map<String, dynamic> json) =>
      _$ShortUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortUserModelToJson(this);
}
