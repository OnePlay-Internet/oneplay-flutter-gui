// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/friend_service.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';
import 'package:oneplay_flutter_gui/app/widgets/appbar/appbarWidget.dart';

import '../../../main.dart';
import '../../widgets/bottom_nav/bottom_nav.dart';
import '../../widgets/exit_popup/exit_popup.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  GameService gameService = Modular.get<GameService>();
  AuthService authService = Modular.get<AuthService>();
  FriendService friendService = Modular.get<FriendService>();
  RestService restService = Modular.get<RestService>();
  RestService2 restService2 = Modular.get<RestService2>();
  Timer? timer;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          selectedIndex = 0;
        });

        if (selectedIndex == 0) return exitDialog(context);

        return false;
      },
      child: Scaffold(
        // key: _scaffoldKey,
        backgroundColor: mainColor,
        // drawer: Drawer(
        //   backgroundColor: mainColor,
        //   child: Column(
        //     children: const [],
        //   ),
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBarWidget().menu(
            context,
            // openDrawer: () {
            //   _scaffoldKey.currentState?.openDrawer();
            // },
            searchTap: () {
              // Modular.to.pushNamedAndRemoveUntil('/search', (r) => false);
              Modular.to.pushNamed('/search');
            },
            profileTap: () {
              //  Modular.to.pushNamedAndRemoveUntil('/setting', (r) => false);
              setState(() {
                selectedIndex = 4;
              });

              print('***** Selected index: $selectedIndex *****');

              Modular.to.pushNamed('/setting');
            },
          ),
        ),
        body: const RouterOutlet(),
        bottomNavigationBar: const BottomNav(),
      ),
    );
  }

  @override
  void initState() {
    _initAuth();
    _initGames();
    _initFriends();
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

  void _initFriends() {
    restService
        .getAllFriends()
        .then((value) => friendService.loadFriends(value));
    restService
        .getPendingReceivedRequests()
        .then((value) => friendService.loadRequests(value));
    restService
        .getPendingSentRequests()
        .then((value) => friendService.loadPendings(value));
  }
}
