// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';
import 'package:oneplay_flutter_gui/app/services/friend_service.dart';
import 'package:oneplay_flutter_gui/app/services/game_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service_2.dart';
import 'package:oneplay_flutter_gui/app/widgets/appbar/appbarWidget.dart';
import 'package:oneplay_flutter_gui/main.dart';

import '../../widgets/Responsive_Widget/responsive_widget.dart';
import '../../widgets/bottom_nav/bottom_nav.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GameService gameService = Modular.get<GameService>();
  AuthService authService = Modular.get<AuthService>();
  FriendService friendService = Modular.get<FriendService>();
  RestService restService = Modular.get<RestService>();
  RestService2 restService2 = Modular.get<RestService2>();
  Timer? timer;
  String? profilePhoto;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      // onWillPop: () => exitDialog(context),
      onWillPop: () async {
        MethodChannel channel = const MethodChannel('flutter-gui');
        channel.invokeMethod("closeApp");
        return true;
      },
      child: OrientationBuilder(builder: (context, orientation) {
        final isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 8;

        return Scaffold(
          // key: scaffoldKey,
          backgroundColor: mainColor,
          // drawer: Drawer(
          //   backgroundColor: mainColor,
          //   child: Column(
          //     children: const [],
          //   ),
          // ),
          appBar: PreferredSize(
            preferredSize: Responsive.isTablet(context)
                ? const Size.fromHeight(65.0)
                : isPortrait == 8 || isPortrait == 8
                    ? const Size.fromHeight(75.0)
                    : const Size.fromHeight(60.0),
            child: AppBarWidget().menu(
              context,
              size: size,
              isPortrait: isPortrait,
              // openDrawer: () {
              //   _scaffoldKey.currentState?.openDrawer();
              // },
              searchTap: () {
                Modular.to.pushNamed('/search');
              },
              profileTap: () {
                if (navigateIdx.value == 4) {
                  return;
                }
                navigateIdx.value = 4;
                previousIndex = 0;
                navigateIdx.notifyListeners();
                Modular.to.pushNamed('/setting');
              },
            ),
          ),
          body: const RouterOutlet(),
          bottomNavigationBar: const BottomNav(),
        );
      }),
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
    final res = await restService.getProfile();
    imageURL.value = res.photo.toString();
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
