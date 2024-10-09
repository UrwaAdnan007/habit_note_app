import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    required this.subtitle,
  });
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: AppColors.blackColor),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: color ?? AppColors.appColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.appColor,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
