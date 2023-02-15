import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../models/subscription_model.dart';
import '../../../widgets/Submit_Button/submit_button.dart';

class SubscriptionTile extends StatelessWidget {
  final List<SubscriptionModel> subscriptionList;

  const SubscriptionTile({
    super.key,
    required this.subscriptionList,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String planName = '';
    String price = '';
    String currency = '';
    // String expiry = '';
    String tilDate = '';

    for (int i = 0; i < subscriptionList.length; i++) {
      planName = subscriptionList[i].subscriptionPackage != null
          ? subscriptionList[i].subscriptionPackage!.planName.toString()
          : '';
      price = subscriptionList[i].subscriptionPackage != null
          ? subscriptionList[i].subscriptionPackage!.value.toString()
          : '';
      currency = subscriptionList[i].subscriptionPackage != null
          ? subscriptionList[i].subscriptionPackage!.currency!.toUpperCase()
          : '';
      // expiry = subscriptionList[i].subscriptionPackage != null
      //     ? subscriptionList[i].subscribedDurationInDays.toString()
      //     : '';
      var date = subscriptionList[i].subscriptionPackage != null
          ? subscriptionList[i].subscriptionActiveTill.toString()
          : '';

      var inputFormat = DateFormat('yyy-MM-dd');
      var apiDate = inputFormat.parse(date);

      var outputFormat = DateFormat('d MMM yyyy');

      tilDate = outputFormat.format(apiDate);
    }
    return Container(
      height:
          subscriptionList.isEmpty ? size.height * 0.06 : size.height * 0.23,
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: size.height * 0.06,
      ),
      decoration: const BoxDecoration(
        color: blackColor2,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                planName,
                style: const TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textSecondaryColor,
                  fontSize: 14,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: Text(
                  '$price $currency',
                  style: const TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.02,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              subscriptionList.isEmpty
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          timePng,
                          height: size.height * 0.02,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Text(
                          // '$expiry days plan.',
                          tilDate,
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
            ],
          ),
          subscriptionList.isEmpty
              ? const SizedBox.shrink()
              : SubmitButton(
                  height: size.height * 0.048,
                  width: size.width * 0.24,
                  buttonTitle: 'Renew',
                  onTap: () {
                    //
                  },
                ),
        ],
      ),
    );
  }
}
