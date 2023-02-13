// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../models/device_history_model.dart';
import '../../../models/ip_location_model.dart';
import '../../../models/session.dart';
import '../../../services/auth_service.dart';
import '../../../services/rest_service.dart';
import '../../../widgets/gradient_text_button/gradient_text_button.dart';

class DeviceTile extends StatefulWidget {
  final DeviceHistoryModel deviceHistory;
  final String userAgent;
  final Function() onTap;

  const DeviceTile({
    super.key,
    required this.deviceHistory,
    required this.userAgent,
    required this.onTap,
  });

  @override
  State<DeviceTile> createState() => _DeviceTileState();
}

class _DeviceTileState extends State<DeviceTile> {
  final RestService _restService = Modular.get<RestService>();
  IPLocationModel ipLocationModel = IPLocationModel();
  String? activeNow;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var deviceName = widget.deviceHistory.device.toString();
    var cityName = ipLocationModel.city != null
        ? ipLocationModel.city.toString()
        : 'Unknown';
    var countryName = ipLocationModel.countryName != null
        ? ipLocationModel.countryName.toString()
        : 'Unknown';

    //

    // var inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss')
    //     .format(DateTime.parse("${widget.deviceHistory.timestamp}"));

    // print('***** Time 1: ${widget.deviceHistory.timestamp} ****');
    // print('***** Time 2: $inputFormat ****');

    // var receivedTime = DateFormat('yyyy/MM/dd HH:mm:ss').parse(inputFormat);

    //

    var inputFormat = DateFormat('yyy-MM-dd');
    var apiDate = inputFormat.parse("${widget.deviceHistory.timestamp}");

    var outputFormat = DateFormat('yyyy, MM, dd');
    var changedFormat = outputFormat.format(apiDate);

    var year = changedFormat.substring(0, 4);
    var month = changedFormat.substring(5, 8);
    var date = changedFormat.substring(10, 12);

    var parsedYear = int.parse(year);
    var parsedMonth = int.parse(month);
    var parsedDate = int.parse(date);

    final parsedDateTime = DateTime(parsedYear, parsedMonth, parsedDate);
    final todayDate = DateTime.now();
    final difference = todayDate.difference(parsedDateTime).inDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userAgent,
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textPrimaryColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  deviceName,
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                activeNow != null
                    ? Text(
                        '$activeNow',
                        style: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textPrimaryColor,
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        '$cityName, \n$countryName',
                        style: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                Text(
                  '$difference days ago',
                  // timeAgo(receivedTime),
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            GradientTextButton(
              title: 'Logout',
              padding: const EdgeInsets.all(5),
              onTap: widget.onTap,
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        const Divider(
          color: basicLineColor,
          thickness: 0.6,
        ),
      ],
    );
  }

  @override
  initState() {
    // if (_isActive(widget.deviceHistory.key.toString())) {
    //   activeNow = 'Active Now';
    // } else {
    _getLocation(widget.deviceHistory.ip ?? '');
    // }

    super.initState();
  }

  // _isActive(String key) {
  //   print('KEY: $key, sessionkey: ${AuthService().userIdToken!.toke}');
  //   print('KEY: $key, sessionkey: ${AuthService().userIdToken!.userId}');
  //   print("*******");
  //   return key == AuthService().sessionKey();
  // }

  _getLocation(String ip) async {
    final res = await _restService.getLocation(ip: ip);
    if (mounted) {
      setState(() {
        ipLocationModel = res;
      });
    }

    return ipLocationModel;
  }
}
