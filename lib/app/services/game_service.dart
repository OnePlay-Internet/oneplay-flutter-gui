import 'package:mobx/mobx.dart';
import 'package:oneplay_flutter_gui/app/models/game_status_model.dart';

part 'game_service.g.dart';

class GameService = GameServiceBase with _$GameService;

abstract class GameServiceBase with Store {
  @observable
  GameStatusModel gameStatus = GameStatusModel.fromJson({});

  @action
  loadStatus(GameStatusModel gameStatusModel) {
    gameStatus = gameStatusModel;
  }

  @action
  dispose() {
    gameStatus = GameStatusModel.fromJson({});
  }
}
