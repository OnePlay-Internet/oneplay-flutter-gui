// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/common.dart';
import '../../../models/user_model.dart';
import '../../../services/rest_service.dart';
import '../../../services/shared_pref_service.dart';
import '../../../widgets/popup/popup_success.dart';
import '../../../widgets/Submit_Button/submit_button.dart';
import '../../../widgets/textfieldsetting/custom_text_field_setting.dart';

class LoginAndSecurityTab extends StatefulWidget {
  const LoginAndSecurityTab({super.key});

  @override
  State<LoginAndSecurityTab> createState() => _LoginAndSecurityTabState();
}

class _LoginAndSecurityTabState extends State<LoginAndSecurityTab> {
  final RestService _restService = Modular.get<RestService>();
  UserModel? userModel;
  bool isLoading = false;

  String email = '';
  String phone = '';
  String password = '';
  String errorPhone = '';
  String errorPassword = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.045,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: size.height * 0.03,
                    ),
                    child: const Text(
                      'Contact',
                      style: TextStyle(
                        fontFamily: mainFontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02,
                        color: textPrimaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  settingsTextField(
                    context: context,
                    textFieldTitle: 'Email',
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    controller: TextEditingController(text: email),
                    enabled: false,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  settingsTextField(
                    context: context,
                    textFieldTitle: 'Phone Number',
                    hintText: 'Phone Number',
                    errorMessage: errorPhone,
                    controller: TextEditingController(text: phone),
                    textInputType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SubmitButton(
                    buttonTitle: 'Update Phone',
                    loadingTitle: 'Updating...',
                    isLoading: isLoading,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (phone.isEmpty) {
                        setState(() => errorPhone = "Enter your phone no.");
                        return;
                      } else if (phone.length != 13) {
                        setState(() => errorPhone = "Invalid phone no.");
                        return;
                      } else {
                        setState(() => errorPhone = "");
                      }
                      _updatePhone();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: size.height * 0.03,
                    ),
                    child: const Text(
                      'Security',
                      style: TextStyle(
                        fontFamily: mainFontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02,
                        color: textPrimaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  settingsTextField(
                    context: context,
                    textFieldTitle: 'Update Password',
                    hintText: 'Update Password',
                    errorMessage: errorPassword,
                    controller: TextEditingController(text: password),
                    textInputType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SubmitButton(
                    buttonTitle: 'Update Password',
                    loadingTitle: 'Updating...',
                    isLoading: isLoading,
                    onTap: () {
                      print('***** Update Password *****');

                      FocusManager.instance.primaryFocus?.unfocus();

                      if (password.isEmpty) {
                        setState(() => errorPassword = "Enter your password");
                        return;
                      } else if (password.length < 8) {
                        setState(() => errorPassword = "at least 8 characters");
                        return;
                      } else {
                        setState(() => errorPassword = "");
                      }
                      _updatePassword();
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),
            ),
          );
  }

  @override
  initState() {
    _getUser();
    _getUserDetailFromSession();
    super.initState();
  }

  _getUserDetailFromSession() {
    var userData = SharedPrefService.getUserDetail();

    if (userData != null || userData != '') {
      var userDataJsonDecode = jsonDecode(userData!);

      userModel = UserModel.fromJson(userDataJsonDecode);

      email = userModel!.email.toString();
      phone = userModel!.phone.toString();
    }
  }

  _getUser() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          setState(() => isLoading = true);

          final res = await _restService.getProfile();

          setState(() {
            userModel = res;
            String userDetail = jsonEncode(userModel);
            SharedPrefService.storeUserDetail(userDetail);

            isLoading = false;
          });
        } finally {
          setState(() => isLoading = false);
        }
      }
    } on SocketException catch (_) {
      showSnackBar(
        'Opps! Please check your internet.',
      );
    }
  }

  _updatePhone() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          setState(() => isLoading = true);

          await _restService.updateProfile(
            phone: phone,
          );
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) {
                Future.delayed(const Duration(milliseconds: 2000), () {
                  setState(() => isLoading = false);

                  Navigator.pop(_);

                  _getUser();
                });

                return alertSuccess(
                  context: context,
                  title: 'Update Phone Success',
                  description: 'Update phone successfully!',
                );
              },
              barrierDismissible: false,
            );
          }
        } on DioError catch (e) {
          print('***** Exeption error: $e *****');
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pop(_);

                  _getUser();
                });

                return alertError(
                  context: context,
                  title: 'Update Error',
                  description: e.error["message"],
                );
              },
              barrierDismissible: false,
            );
          }
        }
      }
    } on SocketException catch (_) {
      showSnackBar(
        'Opps! Please check your internet.',
      );
    }
  }

  _updatePassword() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          setState(() => isLoading = true);

          await _restService.updatePassword(
            updatePassword: password,
          );

          if (mounted) {
            showDialog(
              context: context,
              builder: (_) {
                Future.delayed(const Duration(milliseconds: 2000), () {
                  setState(() => isLoading = false);

                  Navigator.pop(_);

                  password = '';
                });

                return alertSuccess(
                  context: context,
                  title: 'Update Password Success',
                  description: 'Update password successfully!',
                );
              },
              barrierDismissible: false,
            );
          }
        } on DioError catch (e) {
          print('***** Exeption error: $e *****');
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pop(_);

                  _getUser();
                });

                return alertError(
                  context: context,
                  title: 'Update Error',
                  description: e.error["message"],
                );
              },
              barrierDismissible: false,
            );
          }
        }
      }
    } on SocketException catch (_) {
      showSnackBar(
        'Opps! Please check your internet.',
      );
    }
  }

  void showSnackBar(String text) {
    final snackBar = ScaffoldMessenger.of(context);
    snackBar.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Done',
          onPressed: snackBar.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
