import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';

class GeneralTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function()? onTap;
  final Function()? onTap2;
  final bool isPrivacy;
  final Function(bool)? onChanged;

  const GeneralTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
    this.onTap2,
    this.isPrivacy = true,
    this.onChanged,
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
          padding: EdgeInsets.only(
            left: size.width * 0.04,
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    onTap2 != null
                        ? InkWell(
                            onTap: onTap2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.04,
                              ),
                              child: Image.asset(
                                deletePng,
                              ),
                            ),
                          )
                        : onChanged != null || onChanged != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                  right: size.width * 0.01,
                                ),
                                child: Transform.scale(
                                  scale: 0.76,
                                  child: CupertinoSwitch(
                                    value: isPrivacy,
                                    thumbColor: textPrimaryColor,
                                    activeColor: purpleColor1,
                                    onChanged: onChanged,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
