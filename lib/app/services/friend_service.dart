import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/friend_model.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';

part 'friend_service.g.dart';

class FriendService = FriendServiceBase with _$FriendService;

abstract class FriendServiceBase with Store {
  @observable
  List<FriendModel> friends = [];

  @observable
  List<FriendModel> pendings = [];

  @observable
  List<FriendModel> requests = [];

  @action
  loadFriends(List<FriendModel> friends) {
    this.friends = friends;
  }

  @action
  loadPendings(List<FriendModel> pendings) {
    this.pendings = pendings;
  }

  @action
  loadRequests(List<FriendModel> requests) {
    this.requests = requests;
  }

  @action
  addFriend(ShortUserModel user, String id) {
    FriendModel friendModel = FriendModel(
      id: id,
      status: FriendStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isOnline: false,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      userId: user.id,
    );
    pendings = [...pendings, friendModel];
  }

  @action
  cancelRequest(FriendModel friend) {
    pendings = pendings.where((element) => element.id != friend.id).toList();
  }

  @action
  deleteFriend(FriendModel friend) {
    friends = friends.where((element) => element.id != friend.id).toList();
  }

  @action
  acceptRequest(FriendModel friend) {
    requests = requests.where((element) => element.id != friend.id).toList();
    friends = [...friends, friend];
  }

  @action
  declineRequest(FriendModel friend) {
    requests = requests.where((element) => element.id != friend.id).toList();
  }
}
