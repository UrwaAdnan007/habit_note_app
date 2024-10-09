import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key, required this.switchText});
  final String switchText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              switchText,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor),
            ),
          ],
        ),
        Switch(
          activeTrackColor: AppColors.appColor,
          activeColor: AppColors.whiteColor,
          inactiveTrackColor: Colors.black12,
          value: true,
          onChanged: (bool value) {},
        ),
      ],
    );
  }
}
