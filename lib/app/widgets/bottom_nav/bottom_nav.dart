import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _item(icon: const Icon(Icons.home), label: 'Home'),
        _item(icon: const Icon(Icons.search), label: "Search"),
        _item(
          icon: SvgPicture.asset(gameStatusIcon),
          label: "",
          isImage: true,
        ),
        _item(icon: const Icon(Icons.people), label: "Social"),
        // _item(icon: const Icon(Icons.store), label: "Store"),
        _item(
          icon: Image.asset(
            settingPng,
            height: 22,
            color: _selectedIndex == 4 ? null : textPrimaryColor,
          ),
          label: "Settings",
          isImage: true,
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: blackColor4,
      unselectedIconTheme: const IconThemeData(
        color: textPrimaryColor,
      ),
      unselectedItemColor: textSecondaryColor,
      showUnselectedLabels: true,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
    );
  }

  void _onTap(int value) {
    if (value == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = value;
    });

    switch (value) {
      case 0:
        Modular.to.pushNamedAndRemoveUntil('/feeds', (r) => false);
        break;
      case 1:
        Modular.to.pushNamedAndRemoveUntil('/search', (r) => false);
        break;
      case 4:
        Modular.to.pushNamedAndRemoveUntil('/setting', (r) => false);
        break;
    }
  }

  BottomNavigationBarItem _item({
    required Widget icon,
    required String label,
    String? tooltip,
    bool isImage = false,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: isImage ? null : _activeIcon(icon),
      label: label,
      tooltip: tooltip,
    );
  }

  ShaderMask _activeIcon(Widget icon) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [purpleColor1, purpleColor2],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: icon,
    );
  }
}
