// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/common.dart';
import '../../../models/device_history_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/rest_service.dart';
import '../../../widgets/gamepad_pop/gamepad_pop.dart';
import '../../../widgets/popup/exit_dialog.dart';
import '../../../widgets/popup/popup_success.dart';
import 'general_tile.dart';

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  final RestService _restService = Modular.get<RestService>();
  List<DeviceHistoryModel> deviceHistory = [];
  bool loading = false;
  String userKey = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.045,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            GeneralTile(
              title: 'Frequently Asked Questions',
              iconPath: freqPng,
              onTap: () {
                _launchURL('https://www.oneplay.in/contact.html');
              },
            ),
            GeneralTile(
              title: 'Support',
              iconPath: supportPng,
              onTap: () {
                //
              },
            ),
            GeneralTile(
              title: 'Terms & Conditions',
              iconPath: tncPng,
              onTap: () {
                _launchURL('https://www.oneplay.in/tnc.html');
              },
            ),
            GeneralTile(
              title: 'Privacy Policy',
              iconPath: policyPng,
              onTap: () {
                _launchURL('https://www.oneplay.in/privacy.html');
              },
            ),
            GeneralTile(
              title: 'Log out',
              iconPath: logoutPng,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ExitDialog(
                      title: 'Do you want to logout?',
                      onNo: () {
                        Navigator.pop(context);
                      },
                      onYes: () {
                        _logoutUser(AuthService().sessionKey());
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  _logoutUser(String userKey) async {
    try {
      final res = await _restService.logoutFromDevice(userKey);
      if (res == true) {
        showDialog(
          context: context,
          builder: (_) {
            Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.pop(_);

              Modular.to.pushNamed('/auth/login');
            });

            return alertSuccess(
              context: context,
              title: 'Logout Success',
              description: 'Logout successfully!',
            );
          },
          barrierDismissible: false,
        );
      }
    } on DioError catch (e) {
      print('***** Exeption error: $e *****');

      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 3000), () {
            Navigator.pop(_);
          });

          return GamepadPop(
            context: _,
            child: alertError(
              context: context,
              title: 'Logout Error',
              description: e.error["message"],
            ),
          );
        },
        barrierDismissible: false,
      );
    }
  }
}
