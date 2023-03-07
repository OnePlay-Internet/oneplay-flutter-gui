import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import '../textfieldsetting/custom_text_field_setting.dart';

class AlertErrorReportDialog extends StatefulWidget {
  final Future Function(String message) onTap;

  const AlertErrorReportDialog({
    super.key,
    required this.onTap,
  });

  @override
  State<AlertErrorReportDialog> createState() => _AlertErrorReportDialogState();
}

class _AlertErrorReportDialogState extends State<AlertErrorReportDialog> {
  final TextEditingController reportController = TextEditingController();
  bool isLoading = false;

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
      content: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03,
              ),
              child: const Text(
                'Report Error',
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            commonDividerWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: settingsTextField(
                context: context,
                height: size.height * 0.09,
                hintText: 'Write here...',
                expands: true,
                maxLines: null,
                controller: reportController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03,
                horizontal: size.width * 0.05,
              ),
              child: SubmitButton(
                width: size.width,
                buttonTitle: 'Send',
                loadingTitle: 'Sending...',
                isLoading: isLoading,
                onTap: () {
                  if (reportController.text != '') {
                    reportError();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reportError() {
    setState(() => isLoading = true);
    widget
        .onTap(reportController.text)
        .whenComplete(() => setState(() => isLoading = true));
  }
}
