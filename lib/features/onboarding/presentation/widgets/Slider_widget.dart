import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.title,
    required this.appName,
    required this.text,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String appName;

  final String image;
  final String subtitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: AppColors.blackColor),
                ),
                Text(
                  appName,
                  style: GoogleFonts.fugazOne(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.blackColor),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Image(
                  image: AssetImage(image),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          color: AppColors.blackColor),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
