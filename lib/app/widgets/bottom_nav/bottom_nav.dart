import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';

import '../../services/rest_service_2.dart';
import '../exit_popup/exit_popup.dart';

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
  int _selectedIndex = 0;

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
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) return showExitBottomSheet(context);
        setState(() {
          _selectedIndex = 0;
          // inerIndex = 0;
        });
        return false;
      },
      child: BottomNavigationBar(
        items: [
          _item(icon: const Icon(Icons.home), label: 'Home'),
          // _item(icon: const Icon(Icons.search), label: "Search"),
          _item(
            icon: Image.asset(
              gamePng,
              height: 22,
              color: _selectedIndex == 1 ? null : textPrimaryColor,
            ),
            label: "Games",
          ),
          _item(
            icon: Observer(
              builder: (context) {
                gameService;
                if (gameService.gameStatus.isRunning == true) {
                  return SvgPicture.asset(gameStatusIcon);
                } else if (gameService.gameStatus.sessionId != null) {
                  return Image.asset(resumePng);
                } else {
                  return Image.asset(inactivePng);
                }
              },
            ),
            label: "",
            isImage: true,
          ),
          _item(
            icon: Image.asset(
              referPng,
              height: 26,
              color: _selectedIndex == 3 ? textPrimaryColor : textPrimaryColor,
            ),
            label: "Refer",
          ),
          // _item(icon: const Icon(Icons.people), label: "Social"),
          // _item(icon: const Icon(Icons.store), label: "Store"),
          _item(
            icon: Image.asset(
              settingPng,
              height: 22,
              color: _selectedIndex == 4 ? null : textPrimaryColor,
            ),
            label: "Settings",
            isImage: true,
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: blackColor4,
        unselectedIconTheme: const IconThemeData(
          color: textPrimaryColor,
        ),
        unselectedItemColor: textSecondaryColor,
        showUnselectedLabels: true,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onTap(int value) {
    if (value == _selectedIndex && _selectedIndex != 0) {
      return;
    }

    setState(() {
      _selectedIndex = value;
    });

    switch (value) {
      case 0:
        Modular.to.pushNamedAndRemoveUntil('/feeds', (r) => false);
        break;
      case 2:
        gameService;
        if (gameService.gameStatus.isRunning == true) {
          Modular.to.pushNamed('/game/${gameService.gameStatus.gameId}');
        } else if (gameService.gameStatus.sessionId != null) {
          //
        }
        break;
      case 4:
        Modular.to.pushNamedAndRemoveUntil('/setting', (r) => false);
        break;
    }
  }

  BottomNavigationBarItem _item({
    required Widget icon,
    required String label,
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
