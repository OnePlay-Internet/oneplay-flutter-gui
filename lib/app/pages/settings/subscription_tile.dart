import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../widgets/renew_button/renew_button.dart';
import '../../widgets/submit_button/submit_button.dart';

class SubscriptionTile extends StatelessWidget {
  const SubscriptionTile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: size.height * 0.01,
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
              const Text(
                'Weekly',
                style: TextStyle(
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
                child: const Text(
                  '\$8.89',
                  style: TextStyle(
                    fontFamily: mainFontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.02,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
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
                  const Text(
                    '16th Sep 2022',
                    style: TextStyle(
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
          RenewButton(
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
