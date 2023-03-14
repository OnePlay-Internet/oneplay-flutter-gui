import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/widgets/focus_zoom/focus_zoom.dart';

class FakeFocus extends StatelessWidget {
  final Widget child;

  const FakeFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FocusZoom(
      zoomEffect: false,
      builder: (focus) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: InkWell(
            focusNode: focus,
            onTap: () {
              if (child is CupertinoSwitch) {
                var c = child as CupertinoSwitch;
                c.onChanged!(!c.value);
              }
            },
            child: child,
          ),
        );
      },
    );
  }
}
