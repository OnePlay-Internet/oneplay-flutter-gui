// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';
import 'package:validators/validators.dart';

import '../../common/common.dart';
import '../../models/signup_model.dart';
import '../../services/rest_service.dart';
import '../../widgets/Submit_Button/submit_button.dart';
import '../../widgets/common_divider.dart';
import '../../widgets/footer/authFooter.dart';
import '../../widgets/popup/popup_success.dart';
import '../../widgets/referral_textfield/referral_textfield.dart';
import '../../widgets/textfield/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String errorName = "";
  String errorEmail = "";
  String errorPhone = "";
  String errorPassword = "";
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final refferedController = TextEditingController();

  int isSelected = 0;
  String selectedGender = 'male';

  List<String> genderList = ['male', 'female', 'other'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 8;

    return OrientationBuilder(
      builder: (context, orientation) {
        return GamepadPop(
          context: context,
          child: SafeArea(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            fontFamily: mainFontFamily,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.02,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isPortrait == 5
                              ? size.width * 0.105
                              : size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: isPortrait == 5
                                    ? size.height * 0.05
                                    : size.height * 0.10,
                              ),
                              child: CustomTextField(
                                labelText: 'Name',
                                hintText: 'User Name',
                                textCtrler: nameController,
                                errorText: errorName,
                              ),
                            ),
                            CustomTextField(
                              labelText: 'Email',
                              hintText: 'Email Address',
                              textCtrler: emailController,
                              errorText: errorEmail,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: isPortrait == 5
                                    ? size.height * 0.05
                                    : size.height * 0.10,
                              ),
                              child: CustomTextField(
                                labelText: 'Phone',
                                hintText: 'Phone',
                                textCtrler: phoneController,
                                errorText: errorPhone,
                                textInputType: TextInputType.phone,
                              ),
                            ),
                            CustomTextField(
                              labelText: 'Password',
                              hintText: 'Password',
                              textCtrler: passController,
                              textInputType: TextInputType.visiblePassword,
                              errorText: errorPassword,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: isPortrait == 5
                                    ? size.height * 0.05
                                    : size.height * 0.10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontFamily: mainFontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.02,
                                      color: textPrimaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: isPortrait == 5
                                        ? size.height * 0.02
                                        : size.height * 0.06,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _icon(
                                        0,
                                        icon: malePng,
                                        isPortraite: isPortrait,
                                      ),
                                      _icon(
                                        1,
                                        icon: femalePng,
                                        isPortraite: isPortrait,
                                      ),
                                      _icon(
                                        2,
                                        icon: transgenderPng,
                                        isPortraite: isPortrait,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            ReferralTextfield(
                              title1: 'Referral ID',
                              title2: 'Referral Name',
                              hintText: 'sample ID',
                              controller: refferedController,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: isPortrait == 5
                                    ? size.height * 0.05
                                    : size.height * 0.10,
                              ),
                              child: bySigningUpFooter(
                                isPortrait: isPortrait,
                              ),
                            ),
                            SubmitButton(
                              buttonTitle: 'Create Account',
                              loadingTitle: 'Signing up...',
                              isLoading: isLoading,
                              height:
                                  isPortrait == 5 ? null : size.height * 0.14,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();

                                var firstName = nameController.text;
                                var lastName = nameController.text;
                                var email = emailController.text;
                                var phone = phoneController.text;
                                var password = passController.text;
                                var refferedId = refferedController.text;

                                if (firstName.isEmpty) {
                                  setState(() => errorName = "Enter your name");
                                  return;
                                } else {
                                  setState(() => errorName = "");
                                }

                                if (email.isEmpty) {
                                  setState(
                                      () => errorEmail = "Enter your email");
                                  return;
                                } else if (!isEmail(email)) {
                                  setState(() =>
                                      errorEmail = "Invalid email address");
                                  return;
                                } else {
                                  setState(() => errorEmail = "");
                                }

                                if (phone.isEmpty) {
                                  setState(() =>
                                      errorPhone = "Enter your phone no.");
                                  return;
                                } else if (phone.length != 10) {
                                  setState(
                                      () => errorPhone = "Invalid phone no.");
                                  return;
                                } else {
                                  setState(() => errorPhone = "");
                                }

                                if (password.isEmpty) {
                                  setState(() =>
                                      errorPassword = "Enter your password");
                                  return;
                                } else if (password.length < 8) {
                                  setState(() =>
                                      errorPassword = "at least 8 characters");
                                  return;
                                } else {
                                  setState(() => errorPassword = "");
                                }

                                signUp(
                                  email: email,
                                  firstName: firstName,
                                  lastName: lastName,
                                  phone: '+91$phone',
                                  gender: selectedGender,
                                  password: password,
                                  refferedId: refferedId,
                                );
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            haveAccount(
                              title: 'Already have an account? ',
                              btnTitle: 'Login',
                              onTap: () => Modular.to.pushNamed('/auth/login'),
                            ),
                          ],
                        ),
                      ),
                      commonDividerWidget(),
                      needHelpWidget(),
                      authFooterWidget()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
    required String password,
    required String refferedId,
  }) async {
    final RestService restService = Modular.get<RestService>();

    setState(() => isLoading = true);

    try {
      SignupModel signupModel = await restService.signup(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: gender,
        password: password,
        refferedId: refferedId,
      );

      if (signupModel.isSignupSuccessfull == true) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (_) {
              Future.delayed(const Duration(milliseconds: 2000), () {
                setState(() => isLoading = false);

                Navigator.pop(_);

                Modular.to.pushNamed('/auth/login');
              });

              return alertSuccess(
                context: context,
                title: 'SignUp Success',
                description: 'Please check your email to confirm your email id',
              );
            },
            barrierDismissible: false,
          );
        }
      }
    } on DioError catch (e) {
      print('***** Exeption : $e *****');

      showDialog(
        context: context,
        builder: (_) {
          Future.delayed(const Duration(milliseconds: 3000), () {
            setState(() => isLoading = false);

            Navigator.pop(_);
          });

          return GamepadPop(
            context: context,
            child: alertError(
              context: context,
              title: 'SignUp Error',
              description: e.error["message"],
            ),
          );
        },
        barrierDismissible: false,
      );
    }
  }

  Widget _icon(int index, {String? icon, int? isPortraite}) {
    Size size = MediaQuery.of(context).size;

    return InkResponse(
      onTap: () {
        selectedGender = genderList[index];

        print("***** Index: $index, Gender: $selectedGender *****");

        setState(() {
          isSelected = index;
        });
      },
      child: Container(
        width: isPortraite == 5 ? size.width * 0.13 : size.width * 0.08,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected == index
                ? [pinkColor1, blueColor1]
                : [mainColor, mainColor],
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.8),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: mainColor,
            ),
            child: Image.asset(
              icon!,
              width: size.width * 0.11,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
