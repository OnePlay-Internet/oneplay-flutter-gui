// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validators/validators.dart';

import '../common/common.dart';
import '../models/signup_model.dart';
import '../services/rest_service.dart';
import '../widgets/common_divider.dart';
import '../widgets/footer/authFooter.dart';
import '../widgets/popup/popup_success.dart';
import '../widgets/referral_textfield/referral_textfield.dart';
import '../widgets/submit_button/submit_button.dart';
import '../widgets/textfield/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  List<String> genderList = [
    'male',
    'female',
    'other',
  ];

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
              description: 'Sign up successfully!',
            );
          },
          barrierDismissible: false,
        );
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

          return alertError(
            context: context,
            title: 'SignUp Error',
            description: e.error["message"],
          );
        },
        barrierDismissible: false,
      );
    }
  }

  Widget _icon(int index, {String? icon}) {
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
        width: size.width * 0.12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: size.width * 0.004,
            color: isSelected == index ? purpleColor1 : mainColor,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: size.width * 0.006,
              color: mainColor,
            ),
          ),
          child: Image.asset(
            icon!,
            width: size.width * 0.11,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                customTextField(
                  labelText: 'Name',
                  hintText: 'User Name',
                  textCtrler: nameController,
                  errorText: errorName,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                customTextField(
                  labelText: 'Email',
                  hintText: 'Email Address',
                  textCtrler: emailController,
                  errorText: errorEmail,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                customTextField(
                  labelText: 'Phone',
                  hintText: 'Phone',
                  textCtrler: phoneController,
                  errorText: errorPhone,
                  textInputType: TextInputType.phone,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                customTextField(
                  labelText: 'Password',
                  hintText: 'Password',
                  textCtrler: passController,
                  textInputType: TextInputType.visiblePassword,
                  errorText: errorPassword,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.11,
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
                        height: size.height * 0.02,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _icon(0, icon: malePng),
                          _icon(1, icon: femalePng),
                          _icon(2, icon: transgenderPng),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                ReferralTextfield(
                  title1: 'Referral ID',
                  title2: 'Referral Name',
                  hintText: 'sample ID',
                  controller: refferedController,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                bySigningUpFooter(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SubmitButton(
                  buttonTitle: 'Create Account',
                  loadingTitle: 'Signing up...',
                  isLoading: isLoading,
                  onTap: () {
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
                      setState(() => errorEmail = "Enter your email");
                      return;
                    } else if (!isEmail(email)) {
                      setState(() => errorEmail = "Invalid email address");
                      return;
                    } else {
                      setState(() => errorEmail = "");
                    }

                    if (phone.isEmpty) {
                      setState(() => errorPhone = "Enter your phone no.");
                      return;
                    } else if (phone.length != 10) {
                      setState(() => errorPhone = "Invalid phone no.");
                      return;
                    } else {
                      setState(() => errorPhone = "");
                    }

                    if (password.isEmpty) {
                      setState(() => errorPassword = "Enter your password");
                      return;
                    } else if (password.length < 8) {
                      setState(() => errorPassword = "at least 8 characters");
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
                  height: size.height * 0.03,
                ),
                haveAccount(
                  title: 'Already have an account? ',
                  btnTitle: 'Login',
                  onTap: () => Modular.to.pushNamed('/auth/login'),
                ),
                commonDividerWidget(),
                needHelpWidget(),
                authFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
