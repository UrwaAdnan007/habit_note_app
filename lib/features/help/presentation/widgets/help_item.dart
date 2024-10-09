import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class HelpItem extends StatelessWidget {
  const HelpItem({
    super.key,
    this.onNotesTap,
    this.onOCRTap,
    this.onResetPasswordTap,
  });
  final VoidCallback? onNotesTap;
  final VoidCallback? onOCRTap;
  final VoidCallback? onResetPasswordTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: onNotesTap,
              child: Container(
                height: height / 10,
                decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ListTile(
                      title: Text(
                        'Notes',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      subtitle: Text(
                        'Tap to view',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 8),
                        child: Image.asset(
                          'assets/icons/note_white.png',
                          width: 30,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
              onTap: onOCRTap,
              child: Container(
                height: height / 10,
                decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ListTile(
                      title: Text(
                        'OCR',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      subtitle: Text(
                        'Tap to view',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 8),
                        child: Image.asset(
                          'assets/icons/ocr_white.png',
                          width: 30,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
                onTap: onResetPasswordTap,
                child: Container(
                  height: height / 10,
                  decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                        title: Text(
                          'Reset Password',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        subtitle: Text(
                          'Tap to view',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          child: Image.asset(
                            'assets/icons/password_white.png',
                            width: 25,
                          ),
                        )),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
