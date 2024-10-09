import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.childPrefix,
    this.maxlines,
    required this.hinttext,
    this.height,
  });
  final String hinttext;
  final Widget childPrefix;

  final double? height;
  final int? maxlines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: height ?? 48,
            child: TextField(
              maxLines: maxlines ?? 4,
              style: GoogleFonts.roboto(
                color: AppColors.textfieldTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: GoogleFonts.roboto(
                  color: AppColors.textfieldTextColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w200,
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                isDense: true,
                prefixIcon: childPrefix,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
