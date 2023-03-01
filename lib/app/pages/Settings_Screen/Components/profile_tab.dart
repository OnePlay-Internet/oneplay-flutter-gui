// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart';

import '../../../../main.dart';
import '../../../common/common.dart';
import '../../../models/user_model.dart';
import '../../../services/rest_service.dart';
import '../../../widgets/popup/popup_success.dart';
import '../../../widgets/Submit_Button/submit_button.dart';
import '../../../widgets/textfieldsetting/custom_text_field_setting.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final RestService _restService = Modular.get<RestService>();
  UserModel? userModel;
  bool isLoading = false;

  String? profilePicture;
  String userName = '';
  String firstName = '';
  String lastName = '';
  String bio = '';
  String errorUserName = '';
  String errorFirstName = '';
  String errorLastName = '';
  String errorBio = '';

  File? imageFile;

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);

        print('***** File name: ${imageFile!.path} *****');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
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
                          'Profile Settings',
                          style: TextStyle(
                            fontFamily: mainFontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.02,
                            color: textPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: size.height * 0.056,
                            width: size.width * 0.12,
                            child: InkWell(
                              onTap: () async {
                                getFromGallery();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  size.height * 0.1,
                                ),
                                child: imageFile != null
                                    ? Image.file(
                                        imageFile!,
                                        fit: BoxFit.cover,
                                        color: Colors.white.withOpacity(0.5),
                                        colorBlendMode: BlendMode.modulate,
                                      )
                                    : profilePicture != null ||
                                            profilePicture != null
                                        ? Image.network(
                                            profilePicture!,
                                            fit: BoxFit.cover,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorBlendMode: BlendMode.modulate,
                                          )
                                        : Image.asset(
                                            femalePng,
                                            fit: BoxFit.cover,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorBlendMode: BlendMode.modulate,
                                          ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          const Text(
                            'Edit profile picture.',
                            style: TextStyle(
                              fontFamily: mainFontFamily,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.02,
                              color: textSecondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      settingsTextField(
                        context: context,
                        textFieldTitle: 'Username',
                        hintText: 'Username',
                        errorMessage: errorUserName,
                        textInputType: TextInputType.name,
                        controller: TextEditingController(text: userName),
                        onChanged: (value) {
                          userName = value;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      settingsTextField(
                        context: context,
                        textFieldTitle: 'First Name',
                        hintText: 'First Name',
                        errorMessage: errorFirstName,
                        textInputType: TextInputType.name,
                        controller: TextEditingController(text: firstName),
                        onChanged: (value) {
                          firstName = value;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      settingsTextField(
                        context: context,
                        textFieldTitle: 'Last Name',
                        hintText: 'Last Name',
                        errorMessage: errorLastName,
                        textInputType: TextInputType.name,
                        controller: TextEditingController(text: lastName),
                        onChanged: (value) {
                          lastName = value;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      settingsTextField(
                        context: context,
                        height: size.height * 0.12,
                        textFieldTitle: 'Bio',
                        hintText: 'White a short bio in under 300 characters',
                        errorMessage: errorBio,
                        expands: true,
                        maxLines: null,
                        controller: TextEditingController(text: bio),
                        onChanged: (value) {
                          bio = value;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SubmitButton(
                        buttonTitle: 'Update Profile',
                        loadingTitle: 'Updating...',
                        isLoading: isLoading,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          print('***** Update Profile *****');

                          if (userName.isEmpty) {
                            setState(
                                () => errorUserName = "Enter your username");
                            return;
                          } else {
                            setState(() => errorUserName = "");
                          }

                          if (!isAlpha(firstName)) {
                            setState(() => errorFirstName =
                                "Please enter valid firstname");
                            return;
                          } else if (firstName.isEmpty) {
                            setState(
                                () => errorFirstName = "Enter your firstname");
                            return;
                          } else if (firstName.length > 15) {
                            setState(() => errorFirstName =
                                "Enter firstname under 15 characters");
                            return;
                          } else {
                            setState(() => errorFirstName = "");
                          }

                          if (!isAlpha(lastName)) {
                            setState(() =>
                                errorLastName = "Please enter valid lastname");
                            return;
                          } else if (lastName.isEmpty) {
                            setState(
                                () => errorLastName = "Enter your lastname");
                            return;
                          } else if (lastName.length > 15) {
                            setState(() => errorLastName =
                                "Enter lastname under 15 characters");
                            return;
                          } else {
                            setState(() => errorLastName = "");
                          }

                          if (bio.isEmpty) {
                            setState(() => errorBio = "Write a short bio");
                            return;
                          } else {
                            setState(() => errorBio = "");
                          }

                          if (imageFile != null) {
                            _updateProfileImage(imageFile!);
                            _updateProfile();
                          } else {
                            _updateProfile();
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: size.height * 0.10,
                  left: size.width * 0.078,
                  child: InkWell(
                    onTap: () async {
                      getFromGallery();
                    },
                    child: Image.asset(
                      editPng,
                      fit: BoxFit.cover,
                      height: size.height * 0.024,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  initState() {
    _getUser();
    imageURL.addListener(() => updateURL(imageURL.value));
    super.initState();
  }

  updateURL(String url) {
    setState(() => profilePicURL = url);
  }

  _getUser() async {
    setState(() => isLoading = true);
    try {
      final res = await _restService.getProfile();

      setState(() {
        userModel = res;
        isLoading = false;
        profilePicture = res.photo.toString();

        userName =
            userModel!.username != null ? userModel!.username.toString() : '';
        firstName = userModel!.firstName.toString();
        lastName = userModel!.lastName.toString();
        bio = userModel!.bio != null ? userModel!.bio.toString() : '';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  _updateProfileImage(File imageFile) async {
    try {
      final response =
          await _restService.updateProfileImage(imageFile: imageFile);

      imageURL.value = response.photo.toString();

      print('***** Profile image updated successfuly! *****');
    } on DioError catch (e) {
      print('***** Profile image not updated! *****');
      print('***** Exeption error: ${e.error} *****');
    }
  }

  _updateProfile() async {
    setState(() => isLoading = true);

    try {
      await _restService.updateProfile(
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
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
              title: 'Update Profile Success',
              description: 'Update profile successfully!',
            );
          },
          barrierDismissible: false,
        );
      }
    } on DioError catch (e) {
      print('***** Exeption error: $e *****');

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
