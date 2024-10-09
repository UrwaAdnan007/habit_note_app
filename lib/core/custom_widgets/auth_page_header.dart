import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AuthPageHeader extends StatelessWidget {
  const AuthPageHeader({
    super.key,
    required this.appbarTitle,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    this.backButtonColor,
  });
  final String appbarTitle;
  final Color backgroundColor;
  final String title;
  final Color? backButtonColor;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
          backgroundColor: backgroundColor,
          leading: Transform.translate(
            offset: const Offset(-20.0, 0.0),
            child: BackButton(
              color: backButtonColor ?? AppColors.appColor,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Transform.translate(
            offset: const Offset(-20.0, 0.0),
            child: Text(
              appbarTitle,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 37,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.blackColor),
              ),
              Text(
                subtitle,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: AppColors.blackColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
