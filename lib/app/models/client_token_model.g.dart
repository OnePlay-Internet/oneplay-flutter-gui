// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientTokenModel _$ClientTokenModelFromJson(Map<String, dynamic> json) =>
    ClientTokenModel(
      token: json['client_token'] as String,
      code: json['code'] as int?,
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$ClientTokenModelToJson(ClientTokenModel instance) =>
    <String, dynamic>{
      'client_token': instance.token,
      'code': instance.code,
      'msg': instance.msg,
    };

ClientTokenResponse _$ClientTokenResponseFromJson(Map<String, dynamic> json) =>
    ClientTokenResponse(
      data: ClientTokenModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientTokenResponseToJson(
        ClientTokenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
