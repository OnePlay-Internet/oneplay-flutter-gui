// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamepad_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GamepadService on GamepadServiceBase, Store {
  late final _$gamepadsAtom =
      Atom(name: 'GamepadServiceBase.gamepads', context: context);

  @override
  List<GamepadModel> get gamepads {
    _$gamepadsAtom.reportRead();
    return super.gamepads;
  }

  @override
  set gamepads(List<GamepadModel> value) {
    _$gamepadsAtom.reportWrite(value, super.gamepads, () {
      super.gamepads = value;
    });
  }

  late final _$messageAtom =
      Atom(name: 'GamepadServiceBase.message', context: context);

  @override
  String? get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String? value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$GamepadServiceBaseActionController =
      ActionController(name: 'GamepadServiceBase', context: context);

  @override
  dynamic connect(GamepadModel gamepad) {
    final _$actionInfo = _$GamepadServiceBaseActionController.startAction(
        name: 'GamepadServiceBase.connect');
    try {
      return super.connect(gamepad);
    } finally {
      _$GamepadServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic disconnect(GamepadModel gamepad) {
    final _$actionInfo = _$GamepadServiceBaseActionController.startAction(
        name: 'GamepadServiceBase.disconnect');
    try {
      return super.disconnect(gamepad);
    } finally {
      _$GamepadServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nullifyMessage() {
    final _$actionInfo = _$GamepadServiceBaseActionController.startAction(
        name: 'GamepadServiceBase.nullifyMessage');
    try {
      return super.nullifyMessage();
    } finally {
      _$GamepadServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gamepads: ${gamepads},
message: ${message}
    ''';
  }
}
