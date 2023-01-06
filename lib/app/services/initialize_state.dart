import 'package:mobx/mobx.dart';

part 'initialize_state.g.dart';

class InitializeState = InitializeSateMixin with _$InitializeState;

abstract class InitializeSateMixin with Store {
  @observable
  String message = 'Please wait...';

  @action
  setMessage(String value) {
    message = value;
  }

  @action
  reset() {
    message = 'Please wait...';
  }
}
