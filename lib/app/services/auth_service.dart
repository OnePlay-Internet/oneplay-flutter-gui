import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/shared_pref_service.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

class UserIdToken {
  String userId;
  String token;

  UserIdToken(
    this.userId,
    this.token,
  );
}

abstract class AuthServiceBase with Store {
  @observable
  UserModel? user;

  @observable
  String? sessionToken = SharedPrefService.getSessionToken();

  @observable
  List<String> wishlist = [];

  @computed
  UserIdToken? get userIdToken {
    if (sessionToken != null) {
      var str = TextUtils.decodeBase64(sessionToken ?? '');
      var result = str.split(':');
      var userId = result.first;
      var token = result.last;
      return UserIdToken(userId, token);
    }
    return null;
  }

  @action
  loadUser(UserModel user) {
    this.user = user;
  }

  @action
  loadWishlist(List<String> gameIds) {
    wishlist = gameIds;
  }

  @action
  Future logout() async {
    user = null;
    sessionToken = null;
    wishlist = [];
    await SharedPrefService.removeSessionToken();
  }

  @action
  Future login(String token) async {
    sessionToken = token;
    await SharedPrefService.storeSessionToken(token);
  }
}
