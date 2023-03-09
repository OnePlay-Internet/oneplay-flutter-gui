import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oneplay_flutter_gui/app/widgets/popup/error_dialog.dart';
import 'package:oneplay_flutter_gui/app/widgets/popup/server_error_dialog.dart';

class ErrorHandler {
  static networkErrorHandler(DioError e, BuildContext context) {
    dynamic dialog;
    if (e.type == DioErrorType.response && e.response?.statusCode == 408) {
      dialog = AlertServerErrorDialog(errorMessage: e.error['message']);
    } else if ([
      DioErrorType.connectTimeout,
      DioErrorType.receiveTimeout,
      DioErrorType.sendTimeout,
    ].contains(e.type)) {
      dialog = const AlertServerErrorDialog(
        errorMessage: 'It looks like service is unreachable, please try again',
      );
    } else {
      dialog = AlertErrorDialog(
        error: e.error['message'],
        errorCode: e.response?.statusCode,
      );
    }

    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }
}
