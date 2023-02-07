import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/common.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile;

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.045,
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
                Container(
                  height: size.height * 0.056,
                  width: size.width * 0.12,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.045,
                    // vertical: size.height * 0.03,
                  ),
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
                          : Image.asset(
                              femalePng,
                              fit: BoxFit.cover,
                              color: Colors.white.withOpacity(0.5),
                              colorBlendMode: BlendMode.modulate,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
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
          ],
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
    );
  }
}
