import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GamepadPop extends StatelessWidget {
  final Widget child;
  final BuildContext context;

  const GamepadPop({super.key, required this.child, required this.context});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey.keyId == 0x200000312) {
            Navigator.of(this.context).pop();
          }
        }
      },
      child: child,
    );
  }
}
