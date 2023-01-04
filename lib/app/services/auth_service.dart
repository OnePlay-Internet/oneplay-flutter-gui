import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/shared_pref_service.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {

  @observable
  UserModel? user;

  @observable
  String? sessionToken = SharedPrefService.getSessionToken();

  @action
  loadUser(UserModel user) {
    this.user = user;
  }

  @action
  Future logout() async {
    user = null;
    sessionToken = null;
    await SharedPrefService.removeSessionToken();
  }

  @action
  Future login(String token) async {
    sessionToken = token;
    await SharedPrefService.storeSessionToken(token);
  }
}
