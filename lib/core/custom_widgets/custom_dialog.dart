import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class MyCustomDialog extends StatelessWidget {
  const MyCustomDialog(
      {super.key,
      required this.onTap1,
      required this.option1Icon,
      required this.option2Icon,
      required this.title,
      required this.onTap2,
      required this.option1text,
      this.backgroundColor,
      this.elevation,
      required this.option2text});
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final String title;
  final String option1Icon;
  final String option2Icon;
  final String option1text;
  final double? elevation;
  final String option2text;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Center(child: Text(title)),
      elevation: elevation ?? 4,
      insetPadding: const EdgeInsets.all(35.0),
      titleTextStyle: GoogleFonts.roboto(
          color: AppColors.blackColor,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      titlePadding: const EdgeInsets.only(top: 2),
      backgroundColor: backgroundColor ?? AppColors.whiteColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: onTap1,
          child: Row(
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 25),
                  child: Image.asset(option1Icon)),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  option1text,
                  style: GoogleFonts.roboto(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: onTap2,
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 25),
                child: Image.asset(
                  option2Icon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  option2text,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
