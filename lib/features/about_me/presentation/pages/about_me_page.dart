import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/about/presentation/pages/about_page.dart';
import 'package:habit_app/features/about_me/presentation/widgets/alert_dialog.dart';
import 'package:habit_app/features/about_me/presentation/widgets/logout_button.dart';
import 'package:habit_app/features/about_me/presentation/widgets/about_me_options_tile.dart';
import 'package:habit_app/features/auth/reset_password/presentation/pages/reset_password_page.dart';
import 'package:habit_app/features/settings/presentation/pages/settings_page.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});
  @override
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
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 40,
                        top: 90,
                        child: CircleAvatar(
                          radius: 50,
                          child: Image.asset('assets/images/profile_img.png',
                              fit: BoxFit.fill),
                        )),
                    Positioned(
                        left: 110,
                        top: 157,
                        child: CircleAvatar(
                          backgroundColor: AppColors.appColor,
                          radius: 16,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Image.asset(
                              'assets/icons/edit_icon.png',
                              width: 20,
                            ),
                          ),
                        )),
                    Positioned(
                      top: 110,
                      left: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: GoogleFonts.roboto(
                              color: AppColors.blackColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'yourmail@gmail.com',
                            style: GoogleFonts.roboto(
                              color: AppColors.blackColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
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
                        flex: 45,
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
                            onTapSettings: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 36, right: 36, bottom: height * 0.3),
                      child: LogOutButton(
                        heightx: 50,
                        onTap: () => showAlertDialog(context),
                        buttonText: 'LOG OUT',
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

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialogWidget(
              title: 'Log out',
              content: 'Are you sure you want to log out?',
              buttonText1: 'No',
              buttonText2: 'Log out',
              // onPressed: () => context.router.maybePop(),
              // onPressed2: () => context.router.maybePop(),
            ));
  }
}
