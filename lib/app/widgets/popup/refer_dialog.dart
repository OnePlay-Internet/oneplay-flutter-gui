// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/common.dart';
import '../../services/auth_service.dart';
import 'terms_and_conditions_dialog.dart';

class AlertReferPopUp extends StatefulWidget {
  const AlertReferPopUp({super.key});

  @override
  State<AlertReferPopUp> createState() => _AlertReferPopUpState();
}

class _AlertReferPopUpState extends State<AlertReferPopUp> {
  String facebookLink = 'https://www.facebook.com/sharer/sharer.php?u=';
  String whatsappLink = 'https://web.whatsapp.com/send?text=';
  String twitterLink = 'https://twitter.com/intent/tweet?url=';
  String telegramLink = 'https://t.me/share/url?url=';
  String linkedinLink = 'https://www.linkedin.com/shareArticle?url=';

  String referURL =
      'https://www.oneplay.in/dashboard/register?ref=${AuthService().userIdToken!.userId}';

  int iconIndex = 0;

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
                              _launchURL(facebookLink + referURL);
                            } else if (iconIndex == 1) {
                              _launchURL(linkedinLink + referURL);
                            } else if (iconIndex == 2) {
                              _launchURL(facebookLink + referURL);
                            } else if (iconIndex == 3) {
                              _launchURL(telegramLink + referURL);
                            } else if (iconIndex == 4) {
                              _launchURL(twitterLink + referURL);
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
                          iconPath: icons2,
                          onTap: (e) async {
                            setState(() => iconIndex = icons2.indexOf(e));

                            if (iconIndex == 0) {
                              _launchURL(whatsappLink + referURL);
                            } else if (iconIndex == 1) {
                              _launchURL(linkedinLink + referURL);
                            } else if (iconIndex == 2) {
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

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
      if (element.indexOf(element) > 0 &&
          element.indexOf(element) < element.length) {
        widgets.add(
          const SizedBox(
            width: 30,
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
    required List<String> iconPath,
    required Function(String e) onTap,
  }) {
    List<Widget> widgets = [];
    for (var element in iconPath) {
      if (element.indexOf(element) > 0 &&
          element.indexOf(element) < element.length) {
        widgets.add(
          const SizedBox(
            width: 30,
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
