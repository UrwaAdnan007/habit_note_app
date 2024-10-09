import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton(
      {super.key,
      required this.buttonText,
      this.heightx,
      this.elevation,
      this.widthx,
      this.onTap,
      this.color});
  final VoidCallback? onTap;
  final String buttonText;
  final double? heightx;
  final double? elevation;
  final double? widthx;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.sizeOf(context).height;
    double buttonWidth = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color ?? AppColors.appColor),
          fixedSize: WidgetStatePropertyAll(
              Size(widthx ?? buttonWidth, heightx ?? buttonHeight * 0.06)),
          minimumSize: WidgetStatePropertyAll(
              Size(widthx ?? buttonWidth, heightx ?? buttonHeight * 0.06)),
          maximumSize: WidgetStatePropertyAll(
              Size(widthx ?? buttonWidth, heightx ?? buttonHeight * 0.06)),
          elevation: WidgetStatePropertyAll(elevation ?? 4),
          shadowColor: const WidgetStatePropertyAll(
            Color.fromARGB(125, 50, 50, 71),
          ),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout_outlined,
              size: 36,
              color: AppColors.whiteColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              buttonText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color:
                    color == null ? AppColors.whiteColor : AppColors.appColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                // height: 19.2,
              ),
            ),
          ],
        ));
  }
}
