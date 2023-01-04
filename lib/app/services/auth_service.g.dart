// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthService on AuthServiceBase, Store {
  late final _$userAtom = Atom(name: 'AuthServiceBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$sessionTokenAtom =
      Atom(name: 'AuthServiceBase.sessionToken', context: context);

  @override
  String? get sessionToken {
    _$sessionTokenAtom.reportRead();
    return super.sessionToken;
  }

  @override
  set sessionToken(String? value) {
    _$sessionTokenAtom.reportWrite(value, super.sessionToken, () {
      super.sessionToken = value;
    });
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthServiceBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthServiceBase.login', context: context);

  @override
  Future<dynamic> login(String token) {
    return _$loginAsyncAction.run(() => super.login(token));
  }

  late final _$AuthServiceBaseActionController =
      ActionController(name: 'AuthServiceBase', context: context);

  @override
  dynamic loadUser(UserModel user) {
    final _$actionInfo = _$AuthServiceBaseActionController.startAction(
        name: 'AuthServiceBase.loadUser');
    try {
      return super.loadUser(user);
    } finally {
      _$AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
sessionToken: ${sessionToken}
    ''';
  }
}