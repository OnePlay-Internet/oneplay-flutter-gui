import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';
import 'package:oneplay_flutter_gui/app/widgets/appbar/appbarWidget.dart';

import '../../widgets/bottom_nav/bottom_nav.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  GameService gameService = Modular.get<GameService>();
  AuthService authService = Modular.get<AuthService>();
  RestService restService = Modular.get<RestService>();
  RestService2 restService2 = Modular.get<RestService2>();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarWidget().menu(context),
      ),
      body: const RouterOutlet(),
      bottomNavigationBar: const BottomNav(),
    );
  }

  @override
  void initState() {
    _initAuth();
    _initGames();
    timer = Timer.periodic(const Duration(minutes: 5), (timer) => _initGames());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    gameService.dispose();
    super.dispose();
  }

  void _initAuth() async {
    authService.loadUser(await restService.getProfile());
    authService.loadWishlist(await restService.getWishlist());
  }

  void _initGames() async {
    gameService.loadStatus(await restService2.getGameStatus());
  }
}
