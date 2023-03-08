import 'package:json_annotation/json_annotation.dart';

part 'gamepad_model.g.dart';

@JsonSerializable()
class GamepadModel {
  @JsonKey(name: 'device_id')
  int id;

  @JsonKey(name: 'vendor_id')
  int vendorId;

  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'controller_number')
  int controllerNumber;

  @JsonKey(name: 'controller_name')
  String name;

  GamepadModel({
    required this.id,
    required this.vendorId,
    required this.productId,
    required this.controllerNumber,
    required this.name,
  });

  factory GamepadModel.fromJson(Map<String, dynamic> json) =>
      _$GamepadModelFromJson(json);

  Map<String, dynamic> toJson() => _$GamepadModelToJson(this);
}
