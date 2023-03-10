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
import '../../../services/shared_pref_service.dart';
import '../../../widgets/popup/ask_dialog.dart';
import '../../../widgets/popup/exit_dialog.dart';
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
  bool? isPrivacy;
  bool isLoading = false;
  String userKey = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    isPrivacy = SharedPrefService.getIsPrivacy();

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
              title: 'Privacy',
              iconPath: privacyPng,
              isPrivacy: isPrivacy!,
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    isPrivacy = value;
                    _setSearchPrivacy(isPrivacy!);
                    SharedPrefService.storeIsPrivacy(isPrivacy!);
                  });
                } else {
                  setState(() {
                    isPrivacy = value;
                    _setSearchPrivacy(isPrivacy!);
                    SharedPrefService.storeIsPrivacy(isPrivacy!);
                  });
                }
              },
            ),
            GeneralTile(
              title: 'Session Data',
              iconPath: pieChartPng,
              onTap2: () async {
                isOpenDialog = true;

                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertAskDialog(
                      title: 'Are you sure?',
                      subTitle:
                          'Do you want to delete all your session \ndata?',
                      onTapNo: () {
                        Navigator.pop(context);
                      },
                      onTapYes: () {
                        Navigator.pop(context);
                        _deleteSessionData();
                      },
                    );
                  },
                );
                setState(() => isOpenDialog = false);
              },
            ),
            GeneralTile(
              title: 'Log out',
              iconPath: logoutPng,
              onTap: () async {
                isOpenDialog = true;

                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return ExitDialog(
                      title: 'Do you want to logout?',
                      isLoading: isLoading,
                      onNo: () {
                        Navigator.pop(context);
                      },
                      onYes: () {
                        _logoutUser(AuthService().sessionKey());
                      },
                    );
                  },
                );
                setState(() => isOpenDialog = false);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _setSearchPrivacy(bool privacy) async {
    try {
      await _restService.setSearchPrivacy(isPrivacy: privacy);
      if (mounted) {
        isOpenDialog = true;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertAskDialog(
              title: 'Success',
              subTitle: privacy == true
                  ? 'Successfully turned on search privacy.'
                  : 'Successfully turned off search privacy.',
              onTapYes: () {
                Navigator.pop(_);
                setState(() => isOpenDialog = false);
              },
            );
          },
        );
      }
    } on DioError catch (e) {
      if (mounted) {
        ErrorHandler.networkErrorHandler(e, context);
      }
    }
  }

  _deleteSessionData() async {
    try {
      final response = await _restService2.deleteSessionData();
      if (response == 'success') {
        if (mounted) {
          isOpenDialog = true;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertAskDialog(
                title: 'Success',
                subTitle: 'Successfully deleted sessions',
                onTapYes: () {
                  Navigator.pop(_);
                  setState(() => isOpenDialog = false);
                },
              );
            },
          );
        }
      }
    } on DioError catch (e) {
      if (mounted) {
        ErrorHandler.networkErrorHandler(e, context);
      }
    }
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

  _logoutUser(String userKey) async {
    setState(() => isLoading = true);

    try {
      final res = await _restService.logoutFromDevice(userKey);
      if (res == true) {
        if (mounted) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pop(context);

            navigateIdx.value = 0;
            navigateIdx.notifyListeners();

            setState(() => isLoading = false);

            Modular.to.pushNamed('/auth/login');
          });
        }

        // if (mounted) {
        //   showDialog(
        //     context: context,
        //     builder: (_) {
        //       Future.delayed(const Duration(milliseconds: 3000), () {
        //         Navigator.pop(_);

        //         Modular.to.pushNamed('/auth/login');
        //       });

        //       return alertSuccess(
        //         context: context,
        //         title: 'Logout Success',
        //         description: 'Logout successfully!',
        //       );
        //     },
        //     barrierDismissible: false,
        //   );
        // }
      }
    } on DioError catch (e) {
      ErrorHandler.networkErrorHandler(e, context);
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
}
