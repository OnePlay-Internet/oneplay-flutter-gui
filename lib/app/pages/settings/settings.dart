import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'profile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Widget> tabs = <Widget>[
      const Tab(
        text: 'Profile',
      ),
      const Tab(
        text: 'Login & Security',
      ),
      const Tab(
        text: 'Subscription',
      ),
      const Tab(
        text: 'Device History',
      ),
    ];

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.055,
                vertical: size.height * 0.02,
              ),
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.02,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: tabs.length,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.0,
                    horizontal: size.width * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        tabs: tabs,
                        isScrollable: true,
                        labelColor: textPrimaryColor,
                        unselectedLabelColor: textSecondaryColor,
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textSecondaryColor,
                          fontSize: 14,
                        ),
                        labelStyle: const TextStyle(
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                          color: textPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            Profile(),
                            Text('data'),
                            Text('data'),
                            Text('data'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}