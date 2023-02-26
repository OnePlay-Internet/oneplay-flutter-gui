import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import 'package:oneplay_flutter_gui/app/widgets/store.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool logginOut = false;
  AuthService authService = Modular.get<AuthService>();
  RestService restService = Modular.get<RestService>();

  List<ShortGameModel> games = [];
  bool starting = false;

  _getGames(String genre) async {
    await restService.getGamesByGenre(genre).then((value) async => {
          if (mounted) setState(() => games = value),
        });
  }

  @override
  void initState() {
    setState(() => starting = true);
    _getGames('').then((value) async {
      if (mounted) setState(() => starting = false);
    });
    super.initState();
  }

  logout() async {
    AuthService authService = Modular.get<AuthService>();
    setState(() => logginOut = true);
    await authService.logout();
    setState(() => logginOut = false);
    Modular.to.navigate('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    return GamepadPop(
      context: context,
      child: Scaffold(
        backgroundColor: mainColor,
        body: starting
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      getStoreContent(
                          GameFeedModel(title: 'All games', games: games),
                          context),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
