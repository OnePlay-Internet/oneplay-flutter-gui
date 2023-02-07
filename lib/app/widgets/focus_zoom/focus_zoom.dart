import 'package:flutter/material.dart';

class FocusZoom extends StatefulWidget {
  final Widget Function(FocusNode) builder;
  final bool zoomEffect;

  const FocusZoom({super.key, required this.builder, this.zoomEffect = true});

  @override
  State<FocusZoom> createState() => _FocusZoomState();
}

class _FocusZoomState extends State<FocusZoom> {
  final _focusNode = FocusNode();
  double scale = 1.0;
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: focused
          ? BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            )
          : null,
      child: widget.zoomEffect
          ? AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 100),
              child: widget.builder(_focusNode),
            )
          : widget.builder(_focusNode),
    );
  }

  @override
  void initState() {
    _focusNode.addListener(() {
      if (focused != _focusNode.hasFocus) {
        setState(() {
          scale = _focusNode.hasFocus ? 0.9 : 1.0;
          focused = _focusNode.hasFocus;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
