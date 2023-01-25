// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendService on FriendServiceBase, Store {
  late final _$friendsAtom =
      Atom(name: 'FriendServiceBase.friends', context: context);

  @override
  List<FriendModel> get friends {
    _$friendsAtom.reportRead();
    return super.friends;
  }

  @override
  set friends(List<FriendModel> value) {
    _$friendsAtom.reportWrite(value, super.friends, () {
      super.friends = value;
    });
  }

  late final _$pendingsAtom =
      Atom(name: 'FriendServiceBase.pendings', context: context);

  @override
  List<FriendModel> get pendings {
    _$pendingsAtom.reportRead();
    return super.pendings;
  }

  @override
  set pendings(List<FriendModel> value) {
    _$pendingsAtom.reportWrite(value, super.pendings, () {
      super.pendings = value;
    });
  }

  late final _$requestsAtom =
      Atom(name: 'FriendServiceBase.requests', context: context);

  @override
  List<FriendModel> get requests {
    _$requestsAtom.reportRead();
    return super.requests;
  }

  @override
  set requests(List<FriendModel> value) {
    _$requestsAtom.reportWrite(value, super.requests, () {
      super.requests = value;
    });
  }

  late final _$FriendServiceBaseActionController =
      ActionController(name: 'FriendServiceBase', context: context);

  @override
  dynamic loadFriends(List<FriendModel> friends) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.loadFriends');
    try {
      return super.loadFriends(friends);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadPendings(List<FriendModel> pendings) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.loadPendings');
    try {
      return super.loadPendings(pendings);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadRequests(List<FriendModel> requests) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.loadRequests');
    try {
      return super.loadRequests(requests);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addFriend(ShortUserModel user, String id) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.addFriend');
    try {
      return super.addFriend(user, id);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancelRequest(FriendModel friend) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.cancelRequest');
    try {
      return super.cancelRequest(friend);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteFriend(FriendModel friend) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.deleteFriend');
    try {
      return super.deleteFriend(friend);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic acceptRequest(FriendModel friend) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.acceptRequest');
    try {
      return super.acceptRequest(friend);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic declineRequest(FriendModel friend) {
    final _$actionInfo = _$FriendServiceBaseActionController.startAction(
        name: 'FriendServiceBase.declineRequest');
    try {
      return super.declineRequest(friend);
    } finally {
      _$FriendServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
friends: ${friends},
pendings: ${pendings},
requests: ${requests}
    ''';
  }
}
