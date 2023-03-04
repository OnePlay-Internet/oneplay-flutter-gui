// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../common/common.dart';
import '../../../models/device_history_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/rest_service.dart';
import '../../../services/rest_service_2.dart';
import '../../../widgets/gamepad_pop/gamepad_pop.dart';
import '../../../widgets/popup/ask_dialog.dart';
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
  final RestService2 _restService2 = Modular.get<RestService2>();
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
                _launchURL('https://www.oneplay.in/contact.html');
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
              title: 'Policy',
              iconPath: policyPng,
              onChanged: (value) {},
            ),
            GeneralTile(
              title: 'Session Data',
              iconPath: policyPng,
              onTap2: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertAskDialog(
                      title: 'Are you sure?',
                      onNo: () {
                        Navigator.pop(context);
                      },
                      onYes: () {
                        _deleteSessionData();
                      },
                    );
                  },
                );
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
                        navigateIdx.value = 0;
                        navigateIdx.notifyListeners();

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
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch $url';
        }
      }
    } on SocketException catch (_) {
      showSnackBar(
        'Opps! Please check your internet.',
      );
    }
  }

  void showSnackBar(String text) {
    final snackBar = ScaffoldMessenger.of(context);
    snackBar.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Done',
          onPressed: snackBar.hideCurrentSnackBar,
        ),
      ),
    );
  }

  _logoutUser(String userKey) async {
    try {
      final res = await _restService.logoutFromDevice(userKey);
      if (res == true) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (_) {
              Future.delayed(const Duration(milliseconds: 3000), () {
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

  _deleteSessionData() async {
    try {
      await _restService2.deleteSessionData();
    } on DioError catch (e) {
      print('***** Exeption error: $e *****');
    }
  }
}
