import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/gamepad_model.dart';

part 'gamepad_service.g.dart';

class GamepadService = GamepadServiceBase with _$GamepadService;

abstract class GamepadServiceBase with Store {
  @observable
  List<GamepadModel> gamepads = [];

  @observable
  String? message;

  @action
  connect(GamepadModel gamepad) {
    if (gamepad.productId > 0) {
      gamepads = [...gamepads, gamepad];
      message = '#${gamepad.id} ${gamepad.name} : Connected';
    }
  }

  @action
  disconnect(GamepadModel gamepad) {
    var newGamepads =
        gamepads.where((element) => element.id != gamepad.id).toList();

    if (gamepads.length > newGamepads.length) {
      gamepads = [...newGamepads];
      message = '#${gamepad.id} ${gamepad.name} : Disconnected';
    }
  }

  @action
  nullifyMessage() {
    message = null;
  }
}
