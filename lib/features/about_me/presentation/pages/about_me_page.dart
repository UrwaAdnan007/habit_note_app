import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/custom_dialog.dart';
import 'package:habit_app/features/about/presentation/pages/about_page.dart';

import 'package:habit_app/features/about_me/presentation/widgets/logout_button.dart';
import 'package:habit_app/features/about_me/presentation/widgets/about_me_options_tile.dart';
import 'package:habit_app/features/about_me/presentation/widgets/signout_dialog.dart';
import 'package:habit_app/features/auth/reset_password/presentation/pages/reset_password_page.dart';

import 'package:image_picker/image_picker.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  Future<Map<String, dynamic>> getUserData() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Check if userId is null
    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    try {
      // Fetch user document
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return userDoc.data() ?? {};
      } else {
        throw Exception('User data not found.');
      }
    } catch (e) {
      // Log and rethrow the error
      throw Exception('Failed to fetch user data: $e');
    }
  }

  // ImagePicker for selecting images
  final ImagePicker _picker = ImagePicker();
  // File to store the selected image
  File? _selectedImage;
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            Expanded(
              flex: 30,
              child: Container(
                // height: height * 0.2,
                width: width,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 40,
                      top: 20,
                      child: Text(
                        'Me',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.blackColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 90,
                      child: _selectedImage != null
                          ? CircleAvatar(
                              radius: 35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: width,
                                ),
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey, radius: 35),
                    ),
                    Positioned(
                        left: 82,
                        top: 140,
                        child: InkWell(
                          onTap: () => imagePickerDialog(context),
                          child: CircleAvatar(
                            backgroundColor: AppColors.appColor,
                            radius: 12,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Image.asset(
                                'assets/icons/edit_icon.png',
                                width: 20,
                              ),
                            ),
                          ),
                        )),
                    FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Positioned(
                            top: 110,
                            left: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] ?? 'UserName not available',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.blackColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  data['email'] ?? 'Email not available',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.blackColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(child: Text('No data found!'));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.blackColor,
            ),
            Expanded(
              flex: 70,
              child: Container(
                // width: width,
                // height: height * 0.7,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                        flex: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: AboutMeOptionsTile(
                            onTapResetPassword: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPasswordPage()),
                            ),
                            onTapAbout: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutPage()),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 36, right: 36, bottom: height * 0.35),
                      child: Expanded(
                        flex: 65,
                        child: LogOutButton(
                          heightx: 40,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => const SignoutDialogWidget(),
                          ),
                          buttonText: 'LOG OUT',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Dialog to allow the user to pick an image from camera or gallery
  void imagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MyCustomDialog(
        option1text: 'Take photo',
        option2text: 'Choose from gallery',
        option1Icon: 'assets/icons/photo_camera_icon.png',
        option2Icon: 'assets/icons/photo_icon.png',
        title: 'New',
        onTap1: () {
          Navigator.of(context).pop();
          _pickImage(ImageSource.camera);
        },
        onTap2: () {
          Navigator.of(context).pop();
          _pickImage(ImageSource.gallery);
        },
      ),
    );
  } // Function to pick an image from the camera or gallery

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
