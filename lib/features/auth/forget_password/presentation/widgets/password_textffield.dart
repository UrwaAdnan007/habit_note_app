import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.hintText,
    this.height,
    this.suffix,
  });

  final double? height;
  final String hintText;
  final Widget? suffix;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisiblePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: widget.height ?? 48,
            child: TextField(
              maxLines: 1,
              style: GoogleFonts.roboto(
                color: AppColors.textfieldTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
              obscureText: isVisiblePassword,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: GoogleFonts.roboto(
                  color: AppColors.textfieldTextColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w200,
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                isDense: true,
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.appColor,
                ),
                suffixIcon: widget.suffix,
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
