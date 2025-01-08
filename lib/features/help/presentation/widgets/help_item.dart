import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class HelpItem extends StatelessWidget {
  const HelpItem({
    super.key,
    this.onResetPasswordTap,
  });

  final VoidCallback? onResetPasswordTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.5, top: height * 0.05),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 60,
          maxHeight: 60,
        ),
        child: GestureDetector(
          onTap: onResetPasswordTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  'Reset Password',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
                subtitle: Text(
                  'Tap to view',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300, fontSize: 13),
                ),
                leading: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                  child: Image.asset(
                    'assets/icons/password_white.png',
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
