// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';

import '../../../main.dart';
import '../../services/rest_service_2.dart';
import '../popup/refer_dialog.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  GameService gameService = Modular.get<GameService>();
  RestService2 restService2 = Modular.get<RestService2>();
  Timer? timer;

  @override
  void initState() {
    _initGames();
    timer =
        Timer.periodic(const Duration(seconds: 10), (timer) => _initGames());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    gameService.dispose();
    super.dispose();
  }

  void _initGames() async {
    gameService.loadStatus(await restService2.getGameStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      backgroundColor: blackColor4,
      unselectedIconTheme: const IconThemeData(
        color: textPrimaryColor,
      ),
      unselectedItemColor: textSecondaryColor,
      showUnselectedLabels: true,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        _item(icon: const Icon(Icons.home), label: 'Home'),
        // _item(icon: const Icon(Icons.search), label: "Search"),
        _item(
          icon: Image.asset(
            gamePng,
            height: 22,
            color: selectedIndex == 1 ? null : textPrimaryColor,
          ),
          label: "Games",
        ),
        _item(
          icon: Observer(
            builder: (context) {
              gameService;
              if (gameService.gameStatus.isRunning == true) {
                return Image.asset(
                  livePng,
                  height: 48,
                );
              } else if (gameService.gameStatus.sessionId != null) {
                return Image.asset(resumePng);
              } else {
                return Image.asset(inActivePng);
              }
            },
          ),
          label: '',
          isImage: true,
        ),
        _item(
          icon: Image.asset(
            referPng,
            height: 26,
            color: selectedIndex == 3 ? textPrimaryColor : textPrimaryColor,
          ),
          label: "Refer",
        ),
        // _item(icon: const Icon(Icons.people), label: "Social"),
        // _item(icon: const Icon(Icons.store), label: "Store"),
        _item(
          icon: Image.asset(
            settingPng,
            height: 22,
            color: selectedIndex == 4 ? null : textPrimaryColor,
          ),
          label: "Settings",
          isImage: true,
        ),
      ],
    );
  }

  void _onTap(int value) {
    // cover case: in game detail go to feed
    // show dialog refer 2nd attempt
    if (value == selectedIndex && selectedIndex != 0 && value != 3) { 
      return;
    }

    setState(() {
      selectedIndex = value;
      print('***** $selectedIndex *****');
    });

    switch (value) {
      case 0:
        Modular.to.pushNamedAndRemoveUntil('/feeds', (r) => false);
        break;
      case 1:
        print('***** Game *****');
        break;
      case 2:
        gameService;
        if (gameService.gameStatus.isRunning == true) {
          print('***** isRunning: ${gameService.gameStatus.isRunning} *****');

          Modular.to.pushNamed('/game/${gameService.gameStatus.gameId}');
        } else if (gameService.gameStatus.sessionId != null) {
          //
        }
        break;
      case 3:
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return const AlertReferPopUp();
          },
        );
        break;
      case 4:
        // Modular.to.pushNamedAndRemoveUntil('/setting', (r) => false);
        Modular.to.pushNamed('/setting');
        break;
    }
  }

  BottomNavigationBarItem _item({
    required Widget icon,
    String? label,
    String? tooltip,
    bool isImage = false,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: isImage ? null : _activeIcon(icon),
      label: label,
      tooltip: tooltip,
    );
  }

  ShaderMask _activeIcon(Widget icon) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [purpleColor1, purpleColor2],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: icon,
    );
  }
}
