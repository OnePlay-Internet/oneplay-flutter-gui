import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

enum FriendStatus {
  pending,
  accepted,
}

@JsonSerializable()
class FriendModel {
  String id;

  @JsonKey(
    fromJson: _statusFromString,
    toJson: _statusToString,
  )
  FriendStatus status;

  @JsonKey(
    name: 'accepted_at',
    fromJson: _dateFromString,
    toJson: _dateToString,
  )
  DateTime? acceptedAt;

  @JsonKey(
    name: 'created_at',
    fromJson: _dateFromString2,
    toJson: _dateToString2,
  )
  DateTime createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _dateFromString2,
    toJson: _dateToString2,
  )
  DateTime updatedAt;

  bool isOnline;

  String? email;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(
    name: 'last_login_timestamp',
    fromJson: _dateFromString,
    toJson: _dateToString,
  )
  DateTime? lastLogin;

  @JsonKey(name: 'profile_image')
  String? profileImage;

  @JsonKey(name: 'user_id')
  String userId;

  String? username;

  FriendModel({
    required this.id,
    required this.status,
    this.acceptedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isOnline,
    this.email,
    this.firstName,
    this.lastName,
    this.lastLogin,
    this.profileImage,
    required this.userId,
    this.username,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendModelToJson(this);

  static DateTime? _dateFromString(String? value) =>
      value != null ? DateTime.parse(value) : null;

  static String? _dateToString(DateTime? value) => value?.toString();

  static DateTime _dateFromString2(String value) => DateTime.parse(value);

  static String _dateToString2(DateTime value) => value.toString();

  static FriendStatus _statusFromString(String value) {
    switch (value) {
      case 'pending':
        return FriendStatus.pending;
      case 'accepted':
        return FriendStatus.accepted;
      default:
        return FriendStatus.pending;
    }
  }

  static String _statusToString(FriendStatus value) {
    switch (value) {
      case FriendStatus.pending:
        return 'pending';
      case FriendStatus.accepted:
        return 'accepted';
      default:
        return 'accepted';
    }
  }
}
