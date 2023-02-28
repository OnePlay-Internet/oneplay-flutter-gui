import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../Submit_Button/submit_button.dart';
import '../common_divider.dart';
import '../textfieldsetting/custom_text_field_setting.dart';

class AlertErrorReportDialog extends StatelessWidget {
  final Function()? onTap;
  final TextEditingController? reportController;
  final bool isLoading;

  const AlertErrorReportDialog({
    super.key,
    this.onTap,
    this.reportController,
    this.isLoading = false,
  });

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
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
