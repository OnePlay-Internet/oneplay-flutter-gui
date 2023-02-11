// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/common.dart';
import '../../models/device_history_model.dart';
import '../../services/rest_service.dart';
import '../../widgets/logout_button/logout_button.dart';
import '../../widgets/popup/popup_success.dart';
import '../../widgets/row_title/row_title.dart';
import 'device_tile.dart';

class DeviceHistory extends StatefulWidget {
  const DeviceHistory({super.key});

  @override
  State<DeviceHistory> createState() => _DeviceHistoryState();
}

class _DeviceHistoryState extends State<DeviceHistory> {
  final RestService _restService = Modular.get<RestService>();
  List<DeviceHistoryModel> deviceHistory = [];
  bool loading = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.045,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.03,
                ),
                child: const Text(
                  'Device History',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              LogoutButton(
                buttonTitle: 'Logout from all',
                onTap: () {
                  _logoutAllUser();
                },
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const RowTitle(
            title1: 'Device',
            title2: 'Location & Activity',
            title3: 'Status',
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const Divider(
            color: basicLineColor,
            thickness: 0.6,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: deviceHistory.length,
              itemBuilder: ((context, index) {
                if (index < deviceHistory.length) {
                  return DeviceTile(
                    deviceHistory: deviceHistory[index],
                    onTap: () {
                      _logoutUser(deviceHistory[index].key.toString());
                    },
                  );
                } else {
                  _onLoad();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    _onLoad();
    index = 0;
    super.initState();
  }

  _onLoad() async {
    setState(() => loading = true);

    try {
      final res = await _restService.getDeviceHistory();
      print('***** Device history: ${res.length} *****');

      setState(() {
        deviceHistory = res;
      });
    } finally {
      setState(() => loading = false);
    }
  }

  _logoutAllUser() async {
    try {
      if (index < deviceHistory.length) {
        var userKey = deviceHistory[index].key.toString();

        final res = await _restService.logoutFromDevice(userKey);
        if (res == true) {
          index++;
          _logoutAllUser();
        }
      } else {
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

          return alertError(
            context: context,
            title: 'Logout Error',
            description: e.error["message"],
          );
        },
        barrierDismissible: false,
      );
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

              _onLoad();
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

          return alertError(
            context: context,
            title: 'Logout Error',
            description: e.error["message"],
          );
        },
        barrierDismissible: false,
      );
    }
  }
}
