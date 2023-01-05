// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InitializeState on InitializeSateMixin, Store {
  late final _$messageAtom =
      Atom(name: 'InitializeSateMixin.message', context: context);

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$InitializeSateMixinActionController =
      ActionController(name: 'InitializeSateMixin', context: context);

  @override
  dynamic setMessage(String value) {
    final _$actionInfo = _$InitializeSateMixinActionController.startAction(
        name: 'InitializeSateMixin.setMessage');
    try {
      return super.setMessage(value);
    } finally {
      _$InitializeSateMixinActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$InitializeSateMixinActionController.startAction(
        name: 'InitializeSateMixin.reset');
    try {
      return super.reset();
    } finally {
      _$InitializeSateMixinActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message}
    ''';
  }
}
