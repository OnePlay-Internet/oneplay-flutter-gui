// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameService on GameServiceBase, Store {
  late final _$gameStatusAtom =
      Atom(name: 'GameServiceBase.gameStatus', context: context);

  @override
  GameStatusModel get gameStatus {
    _$gameStatusAtom.reportRead();
    return super.gameStatus;
  }

  @override
  set gameStatus(GameStatusModel value) {
    _$gameStatusAtom.reportWrite(value, super.gameStatus, () {
      super.gameStatus = value;
    });
  }

  late final _$GameServiceBaseActionController =
      ActionController(name: 'GameServiceBase', context: context);

  @override
  dynamic loadStatus(GameStatusModel gameStatusModel) {
    final _$actionInfo = _$GameServiceBaseActionController.startAction(
        name: 'GameServiceBase.loadStatus');
    try {
      return super.loadStatus(gameStatusModel);
    } finally {
      _$GameServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$GameServiceBaseActionController.startAction(
        name: 'GameServiceBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$GameServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gameStatus: ${gameStatus}
    ''';
  }
}
