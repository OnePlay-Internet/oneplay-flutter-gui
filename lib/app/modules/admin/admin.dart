import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/modules/admin/admin_widget.dart';
import 'package:oneplay_flutter_gui/app/pages/feeds.dart';
import 'package:oneplay_flutter_gui/app/pages/game.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';

class AdminModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthService()),
        Bind((i) => RestService(i.get())),
        Bind((i) => GameService()),
        Bind((i) => RestService2(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const AdminWidget(),
          children: [
            ChildRoute('/feeds', child: (context, args) => const Feeds()),
            ChildRoute(
              '/game/:id',
              child: (context, args) => Game(args.params['id']),
            ),
          ],
        )
      ];
}
