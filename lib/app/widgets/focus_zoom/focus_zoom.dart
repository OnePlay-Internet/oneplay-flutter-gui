import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/services/gamepad_service.dart';

class FocusZoom extends StatefulWidget {
  final Widget Function(FocusNode) builder;
  final bool zoomEffect;

  const FocusZoom({
    super.key,
    required this.builder,
    this.zoomEffect = true,
  });

  @override
  State<FocusZoom> createState() => _FocusZoomState();
}

class _FocusZoomState extends State<FocusZoom> {
  final _focusNode = FocusNode();
  double scale = 1.0;
  bool focused = false;
  bool listening = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var gamepads = Modular.get<GamepadService>().gamepads;
        return Container(
          decoration: focused && gamepads.isNotEmpty
              ? BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                )
              : null,
          child: widget.zoomEffect && gamepads.isNotEmpty
              ? AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 100),
                  child: widget.builder(_focusNode),
                )
              : widget.builder(_focusNode),
        );
      },
    );
  }

  @override
  void initState() {
    _focusNode.addListener(_handleFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  void _handleFocusChanged() {
    if (focused != _focusNode.hasFocus) {
      setState(() {
        scale = _focusNode.hasFocus ? 0.9 : 1.0;
        focused = _focusNode.hasFocus;
      });
    }

    // if (_focusNode.hasFocus) {
    //   _attachKeyboardIfDetached();
    // } else {
    //   _detachKeyboardIfAttached();
    // }
  }

  void _attachKeyboardIfDetached() {
    if (listening) {
      return;
    }
    RawKeyboard.instance.addListener(_handleRawKeyEvent);
    listening = true;
  }

  void _detachKeyboardIfAttached() {
    if (!listening) {
      return;
    }
    RawKeyboard.instance.removeListener(_handleRawKeyEvent);
    listening = false;
  }

  void _handleRawKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey.keyId == 0x100000301) {
        _focusNode.nextFocus();
      } else if (event.logicalKey.keyId == 0x100000304) {
        _focusNode.previousFocus();
      }
    }
  }
}
