import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/auth/forget_password/presentation/pages/forget_password_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
        child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(gradient: AppColors.drawerGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 36, left: 30),
                //   child: DrawerButton(
                //     color: AppColors.appColor,
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 90, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HaBIT Note',
                        style: GoogleFonts.fugazOne(
                            fontWeight: FontWeight.w400,
                            fontSize: 26,
                            color: AppColors.blackColor),
                      ),
                      Text(
                        'V1.0.0',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: AppColors.blackColor),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 0.8,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordPage()),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lock),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Forgot Password',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 19,
                                    color: AppColors.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.admin_panel_settings_rounded),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Privacy Policy',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                  color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.description),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Terms of Use',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                  color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
