import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/about/presentation/widgets/about_options.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
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
                          title: Text(
                            'About',
                            style: GoogleFonts.roboto(
                              color: AppColors.blackColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: AppColors.blackColor,
                            ),
                            onPressed: () => Navigator.pop(context),
                          )),
                    ),
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 110,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 65,
              child: Container(
                  color: AppColors.whiteColor, child: const AboutOptions())),
        ],
      ),
    );
  }
}
