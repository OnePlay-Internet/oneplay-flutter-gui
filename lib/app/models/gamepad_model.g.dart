// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamepad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamepadModel _$GamepadModelFromJson(Map<String, dynamic> json) => GamepadModel(
      id: json['device_id'] as int,
      vendorId: json['vendor_id'] as int,
      productId: json['product_id'] as int,
      controllerNumber: json['controller_number'] as int,
      name: json['controller_name'] as String,
    );

Map<String, dynamic> _$GamepadModelToJson(GamepadModel instance) =>
    <String, dynamic>{
      'device_id': instance.id,
      'vendor_id': instance.vendorId,
      'product_id': instance.productId,
      'controller_number': instance.controllerNumber,
      'controller_name': instance.name,
    };
