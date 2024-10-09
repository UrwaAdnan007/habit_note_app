import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/auth/reset_password/presentation/pages/reset_password_page.dart';
import 'package:habit_app/features/help/presentation/widgets/help_item.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Expanded(
              flex: 30,
              child: Container(
                color: AppColors.appColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 18),
                      child: AppBar(
                        backgroundColor: AppColors.appColor,
                        automaticallyImplyLeading: false,
                        title: Text(
                          'Help',
                          style: GoogleFonts.roboto(
                            color: AppColors.blackColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                            // height: 19.2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        left: width * 0.14,
                      ),
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      child: Text(
                        'User Guide',
                        style: GoogleFonts.roboto(
                          color: AppColors.whiteColor,
                          fontSize: 31.0,
                          fontWeight: FontWeight.w400,
                          // height: 19.2,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 70,
              child: Container(
                color: AppColors.whiteColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: HelpItem(
                      onResetPasswordTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()),
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
