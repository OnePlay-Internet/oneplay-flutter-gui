import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/shared_pref_service.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  final RestService _restService;

  @observable
  ObservableFuture<UserModel?> _user = ObservableFuture.value(null);

  @observable
  String? sessionToken = SharedPrefService.getSessionToken();

  @computed
  UserModel? get user => _user.value;

  AuthServiceBase(this._restService);

  @action
  loadUser() {
    _user = _restService.getProfile().toMobxFuture();
  }

  @action
  logout() async {
    _user = _user.replace(Future.value(null));
    sessionToken = null;
    await SharedPrefService.removeSessionToken();
    Modular.to.navigate('/auth/login');
  }

  @action
  login(String token) async {
    sessionToken = token;
    await SharedPrefService.storeSessionToken(token);
    Modular.to.navigate('/feeds');
  }
}
