import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../common/common.dart';
import '../../../models/subscription_model.dart';

class SubscriptionHistoryTile extends StatelessWidget {
  final SubscriptionModel subscriptionModel;

  const SubscriptionHistoryTile({
    super.key,
    required this.subscriptionModel,
  });

  String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var inputFormat = DateFormat('yyy-MM-dd');
    var apiDate = inputFormat.parse(
      subscriptionModel.payment!.createdAt.toString(),
    );

    var outputFormat = DateFormat('dd.MM.yyyy');
    var subscriptionDate = outputFormat.format(apiDate);

    var planName = subscriptionModel.subscriptionPackage!.planName.toString();
    var currency =
        subscriptionModel.subscriptionPackage!.currency!.toUpperCase();
    var planRate = subscriptionModel.subscriptionPackage!.value.toString();
    var subscriptionStatus = capitalize(
      subscriptionModel.subscriptionStatus.toString(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subscriptionDate,
              style: const TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textPrimaryColor,
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$planName Edition.',
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text(
                  '$currency $planRate',
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                    color: textPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            subscriptionStatus == 'Done'
                ? Text(
                    subscriptionStatus,
                    style: const TextStyle(
                      fontFamily: mainFontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      color: textPrimaryColor,
                      fontSize: 14,
                    ),
                  )
                : GradientText(
                    subscriptionStatus,
                    style: const TextStyle(
                      fontFamily: mainFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.02,
                      decorationThickness: 1,
                    ),
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ltr,
                    colors: const [purpleColor2, purpleColor1],
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
}
