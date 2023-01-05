import 'package:json_annotation/json_annotation.dart';

part 'client_token_model.g.dart';

@JsonSerializable()
class ClientTokenModel {
  @JsonKey(name: 'client_token')
  String token;

  int? code;

  String msg;

  ClientTokenModel({
    required this.token,
    this.code,
    required this.msg,
  });

  factory ClientTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ClientTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientTokenModelToJson(this);
}

@JsonSerializable()
class ClientTokenResponse {
  ClientTokenModel data;

  ClientTokenResponse({required this.data});

  factory ClientTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClientTokenResponseToJson(this);
}
