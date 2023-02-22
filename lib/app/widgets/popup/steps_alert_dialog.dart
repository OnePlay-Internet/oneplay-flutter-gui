import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'first_step.dart';
import 'second_step.dart';

class AlertStepsPopUp extends StatefulWidget {
  final Function()? onTap;

  const AlertStepsPopUp({
    super.key,
    this.onTap,
  });

  @override
  State<AlertStepsPopUp> createState() => _AlertStepsPopUpState();
}

class _AlertStepsPopUpState extends State<AlertStepsPopUp> {
  final controller = PageController();
  bool isShowBottom = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

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
        height: isShowBottom == true ? size.height * 0.78 : size.height * 0.62,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text(
              'Before you start',
              style: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
                color: textPrimaryColor,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Divider(
              color: basicLineColor,
              thickness: 0.6,
            ),
            Flexible(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    // isLastPage = index == widget.pageIndex;
                  });
                },
                children: [
                  FirstStep(
                    onTap: () {
                      setState(() {
                        isShowBottom = true;
                      });

                      controller.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  SecondStep(
                    isShowBottom: isShowBottom,
                    onTap: widget.onTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
