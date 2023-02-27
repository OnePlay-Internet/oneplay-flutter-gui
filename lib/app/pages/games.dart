import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import 'package:oneplay_flutter_gui/app/widgets/store/store.dart';

import '../widgets/gradient_border_button.dart';
import '../widgets/store/game_filter.dart';

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
  List<GameFilter> filters = [
    const AllGamesFilter(),
    const ReleaseDateFilter(
        title: 'Best of 2021',
        releaseDate: '2020-12-31T18:30:00.000Z#2021-12-31T18:30:00.000Z'),
    const ReleaseDateFilter(
        title: 'Best of 2020',
        releaseDate: '2019-12-31T18:30:00.000Z#2020-12-31T18:30:00.000Z'),
    const PlayTimeFilter(title: 'Top 20', playTime: 10),
    const IsFreeFilter(title: 'Free games'),
    const StoresFilter(title: 'Steam', stores: 'Steam'),
    const StoresFilter(title: 'Epic Games', stores: 'Epic Games'),
    const StoresFilter(title: 'Ubisoft', stores: 'Ubisoft'),
  ];
  GameFilter? currentFilter;
  bool starting = false;
  bool updating = false;

  @override
  void initState() {
    setState(() => starting = true);
    currentFilter ??= filters[0];

    restService.getTopDevelopers(3).then((list) {
      for (String d in list) {
        filters.add(DeveloperFilter(title: d, developer: d));
      }
    });
    restService.getTopGenres(3).then((list) {
      for (String g in list) {
        filters.add(GenresFilter(title: g, genres: g));
      }
    });
    restService.getTopPublishers(3).then((list) {
      for (String p in list) {
        filters.add(PublisherFilter(title: p, publisher: p));
      }
    });

    currentFilter!.getGames().then((value) async {
      if (mounted) {
        games = value;
        setState(() {
          starting = false;
        });
      }
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
                        SizedBox(
                            height: 90,
                            child: ListView(
                              padding: const EdgeInsets.all(20),
                              scrollDirection: Axis.horizontal,
                              children: filters
                                  .map((e) => Row(children: [
                                        GradientBorderButton(
                                          strokeWidth: 2,
                                          radius: 25,
                                          gradient: const LinearGradient(
                                            colors: [
                                              purpleColor2,
                                              purpleColor1
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          color: (e != currentFilter)
                                              ? blackColor4
                                              : null,
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(e.title,
                                                  style: const TextStyle(
                                                    fontFamily: mainFontFamily,
                                                    fontSize: 20,
                                                    letterSpacing: 0.02,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white,
                                                  ))),
                                          onPressed: () {
                                            setState(() => updating = true);
                                            currentFilter = e;
                                            currentFilter!
                                                .getGames()
                                                .then((value) => setState(() {
                                                      games = value;
                                                      updating = false;
                                                    }));
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ]))
                                  .toList(),
                            )),
                        updating
                            ? const Center(child: CircularProgressIndicator())
                            : getStoreContent(
                                GameFeedModel(
                                    title: currentFilter!.title, games: games),
                                context),
                      ],
                    ),
                  ),
                )),
    );
  }
}
