import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/common.dart';
import '../../../models/subscription_model.dart';
import '../../../services/rest_service.dart';
import '../../../widgets/row_title/row_title.dart';
import 'subscription_history_tile.dart';
import 'subscription_tile.dart';

class SubscriptionTab extends StatefulWidget {
  const SubscriptionTab({super.key});

  @override
  State<SubscriptionTab> createState() => _SubscriptionTabState();
}

class _SubscriptionTabState extends State<SubscriptionTab> {
  final RestService _restService = Modular.get<RestService>();
  List<SubscriptionModel> subscriptionList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.045,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                  ),
                  child: const Text(
                    'Current Subcription',
                    style: TextStyle(
                      fontFamily: mainFontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textPrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                SubscriptionTile(
                  subscriptionList: subscriptionList,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                  ),
                  child: const Text(
                    'Subcription History',
                    style: TextStyle(
                      fontFamily: mainFontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textPrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const RowTitle(
                  title1: 'Date',
                  title2: 'Subscription Type',
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
                    itemCount: subscriptionList.length,
                    itemBuilder: ((context, index) {
                      return SubscriptionHistoryTile(
                        subscriptionModel: subscriptionList[index],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  initState() {
    _getCurrentSubscription();
    _getSubscriptionHistory();
    super.initState();
  }

  _getCurrentSubscription() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          setState(() => isLoading = true);

          final res = await _restService.getCurrentSubscription();

          setState(() {
            subscriptionList = res;
            isLoading = false;
          });
        } finally {
          setState(() => isLoading = false);
        }
      }
    } on SocketException catch (_) {
      showSnackBar(
        'Opps! Please check your internet.',
      );
    }
  }

  _getSubscriptionHistory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          setState(() => isLoading = true);

          final res = await _restService.getSubscriptionHistory();

          setState(() {
            subscriptionList = res;
            isLoading = false;
          });
        } finally {
          setState(() => isLoading = false);
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
}
