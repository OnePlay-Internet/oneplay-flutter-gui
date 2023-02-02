import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/modules/admin/admin_widget.dart';
import 'package:oneplay_flutter_gui/app/pages/feeds.dart';
import 'package:oneplay_flutter_gui/app/pages/game/game.dart';
import 'package:oneplay_flutter_gui/app/pages/games_list.dart';
import 'package:oneplay_flutter_gui/app/pages/search.dart';
import 'package:oneplay_flutter_gui/app/pages/users_list.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/friend_service.dart';
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
        Bind((i) => FriendService()),
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
            ChildRoute('/search', child: (context, args) => const Search()),
            ChildRoute(
              '/search/games',
              child: (context, args) =>
                  GamesList(query: args.queryParams['q'] ?? ''),
            ),
            ChildRoute(
              '/search/users',
              child: (context, args) =>
                  UsersList(query: args.queryParams['q'] ?? ''),
            ),
          ],
        )
      ];
}
