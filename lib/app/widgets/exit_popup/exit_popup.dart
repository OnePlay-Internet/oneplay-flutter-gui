import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../popup/exit_dialog.dart';

Future<bool> exitDialog(context) async {
  bool? exitApp = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return ExitDialog(
        title: 'Do you want to Exit?',
        onNo: () {
          Navigator.of(context).pop(false);
        },
        onYes: () {
          MethodChannel channel = const MethodChannel('flutter-gui');
          channel.invokeMethod("closeApp");
          Navigator.of(context).pop(true);
        },
      );
    },
  );

  return exitApp ?? false;
}
