import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../widgets/row_title/row_title.dart';
import 'subscription_history_tile.dart';
import 'subscription_tile.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

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
          SubscriptionTile(),
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
          SubscriptionHistoryTile(),
        ],
      ),
    );
  }
}
