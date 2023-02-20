import 'package:flutter/material.dart';

import '../../../common/common.dart';

class GeneralTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function()? onTap;

  const GeneralTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height * 0.06,
          width: size.width,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          decoration: const BoxDecoration(
            color: blackColor4,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                width: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Text(
                title,
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
        ),
      ),
    );
  }
}
