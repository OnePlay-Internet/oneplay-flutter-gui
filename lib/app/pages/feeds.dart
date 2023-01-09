import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/theme/color.dart';
import 'package:oneplay_flutter_gui/app/mocking/mock.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool logginOut = false;
  AuthService authService = Modular.get<AuthService>();

  logout() async {
    AuthService authService = Modular.get<AuthService>();
    setState(() => logginOut = true);
    await authService.logout();
    setState(() => logginOut = false);
    Modular.to.navigate('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.75,
              ),
              items: imgListBanner
                  .map((item) => Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(imageUrl: item)),
                      ))
                  .toList(),
            )
          ],
        ),
      )),
    );
    // return Container(
    //   padding: const EdgeInsets.all(4),
    //   alignment: Alignment.center,
    //   child: Column(
    //     children: [
    //       Observer(builder: (_) {
    //         return Text('Hi ${authService.user?.firstName}');
    //       }),
    //       const SizedBox(height: 24),
    //       OutlinedButton(
    //         onPressed: logginOut ? null : logout,
    //         child: const Text('Logout'),
    //       ),
    //       const SizedBox(height: 24),
    //       OutlinedButton(
    //         onPressed: () => Modular.to.pushNamed(
    //             '/game/28428948074d7e424071f3a7209523bbd22d8d8e1d59d952ba590553b61fc358'),
    //         child: const Text('Play'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
