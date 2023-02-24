// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../common/common.dart';
import '../../common/utils/questions.dart';
import 'terms_and_conditions_dialog.dart';

enum SocialMedia {
  facebook,
  linkedin,
  messanger,
  telegram,
  twiter,
  whatsapp,
  email,
}

class AlertReferPopUp extends StatefulWidget {
  const AlertReferPopUp({super.key});

  @override
  State<AlertReferPopUp> createState() => _AlertReferPopUpState();
}

class _AlertReferPopUpState extends State<AlertReferPopUp> {
  int iconIndex = 0;
  int iconIndex2 = 0;

  List<String> icons1 = [
    facebookPng,
    linkedInPng,
    messangerPng,
    telegramPng,
    twiterPng,
  ];

  List<String> icons2 = [
    whatsappPng,
    emailPng,
    linkPng,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: mainColor,
      contentPadding: const EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.all(
        size.width * 0.05,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [pinkColor1, blueColor1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.6),
          child: Container(
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              width: size.width,
              height: size.height * 0.73,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        Modular.to
                            .pushNamedAndRemoveUntil('/feeds', (r) => false);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          closePng,
                        ),
                      ),
                    ),
                    Image.asset(
                      refer2Png,
                      height: size.height * 0.23,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.038,
                      ),
                      child: const Text(
                        'Refer a Friend',
                        style: TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Text(
                      'Enjoy one month of Free OnePlay \nSubscription when you invite someone',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: mainFontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02,
                        color: textSecondaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.028,
                        horizontal: size.width * 0.3,
                      ),
                      child: const Divider(
                        height: 1,
                        color: basicLineColor,
                        thickness: 1.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: iconsRow1(
                          iconPath: icons1,
                          onTap: (e) {
                            setState(() => iconIndex = icons1.indexOf(e));

                            if (iconIndex == 0) {
                              Navigator.pop(context);

                              share(SocialMedia.facebook);
                            } else if (iconIndex == 1) {
                              Navigator.pop(context);

                              share(SocialMedia.linkedin);
                            } else if (iconIndex == 2) {
                              Navigator.pop(context);

                              share(SocialMedia.facebook);
                            } else if (iconIndex == 3) {
                              Navigator.pop(context);

                              share(SocialMedia.telegram);
                            } else if (iconIndex == 4) {
                              Navigator.pop(context);

                              share(SocialMedia.twiter);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: iconsRow2(
                          iconPath2: icons2,
                          value: iconIndex2,
                          onTap: (e) async {
                            setState(() => iconIndex2 = icons2.indexOf(e));

                            if (iconIndex2 == 0) {
                              Navigator.pop(context);

                              share(SocialMedia.whatsapp);
                            } else if (iconIndex2 == 1) {
                              Navigator.pop(context);

                              share(SocialMedia.email);
                            } else if (iconIndex2 == 2) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: mainColor,
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    'Copied on clipboard',
                                    style: TextStyle(
                                      fontFamily: mainFontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.02,
                                      color: textPrimaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );

                              await Clipboard.setData(
                                ClipboardData(text: referURL),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.034,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const AlertTermsAndCondition();
                            },
                          );
                        },
                        child: const Text(
                          'T&C Applicable',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textSecondaryColor,
                            fontFamily: mainFontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            decorationThickness: 1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future share(SocialMedia socialPlatform) async {
    final urlShare = Uri.encodeFull(referURL);

    final urls = {
      SocialMedia.facebook: facebookLink + urlShare,
      SocialMedia.linkedin: linkedinLink + urlShare,
      SocialMedia.messanger: messangerLink + urlShare,
      SocialMedia.telegram: telegramLink + urlShare,
      SocialMedia.twiter: twitterLink + urlShare,
      SocialMedia.whatsapp: whatsappLink + urlShare,
      SocialMedia.email: emailLink + urlShare,
    };

    final url = urls[socialPlatform]!;
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> iconsRow1({
    required List<String> iconPath,
    required Function(String e) onTap,
  }) {
    List<Widget> widgets = [];
    for (var element in iconPath) {
      if (iconPath.indexOf(element) > 0 &&
          iconPath.indexOf(element) < iconPath.length) {
        widgets.add(
          const SizedBox(
            width: 0,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap(element),
          child: Image.asset(
            element,
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> iconsRow2({
    required List<String> iconPath2,
    required Function(String e) onTap,
    required int value,
  }) {
    List<Widget> widgets = [];
    for (var element in iconPath2) {
      if (iconPath2.indexOf(element) > 0 &&
          iconPath2.indexOf(element) < iconPath2.length) {
        widgets.add(
          const SizedBox(
            width: 0,
          ),
        );
      }
      widgets.add(
        InkWell(
          onTap: () => onTap(element),
          child: Image.asset(
            element,
          ),
        ),
      );
    }
    return widgets;
  }
}
