import 'package:flutter/material.dart';

import '../../common/common.dart';

class ReferralTextfield extends StatelessWidget {
  final String title1;
  final String title2;
  final String hintText;
  final TextEditingController controller;

  const ReferralTextfield({
    super.key,
    this.title1 = '',
    this.title2 = '',
    this.hintText = '',
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.11,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Referral ID',
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 14,
                ),
              ),
              Text(
                'Referral Name',
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
          SizedBox(
            height: size.height * 0.01,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'sample ID',
              hintStyle: TextStyle(
                fontFamily: mainFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textSecondaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: blackColor1,
                  width: 2,
                ),
              ),
            ),
            controller: controller,
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(
              fontFamily: mainFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
              color: textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
