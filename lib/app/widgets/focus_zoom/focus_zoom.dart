import 'package:flutter/material.dart';

class FocusZoom extends StatefulWidget {
  final Widget Function(FocusNode) builder;

  const FocusZoom({super.key, required this.builder});

  @override
  State<FocusZoom> createState() => _FocusZoomState();
}

class _FocusZoomState extends State<FocusZoom> {
  final _focusNode = FocusNode();
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: scale != 1.0
          ? BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            )
          : null,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: widget.builder(_focusNode),
      ),
    );
  }

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() => scale = _focusNode.hasFocus ? 0.9 : 1.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
