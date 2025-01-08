import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.hintText,
    this.height,
    this.controller,
    this.validator,
    this.hinttextColor,
  });

  final double? height;
  final String hintText;
  final TextEditingController? controller;
  final Color? hinttextColor;
  final FormFieldValidator? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        maxLines: 1,
        validator: widget.validator,
        controller: widget.controller,
        style: GoogleFonts.roboto(
          color: AppColors.textfieldTextColor,
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
        ),
        obscureText: _isObscured,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.roboto(
            color: widget.hinttextColor ?? AppColors.textfieldTextColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          helperText: ' ',
          constraints:
              BoxConstraints(maxHeight: widget.height ?? 65, minHeight: 65),
          contentPadding: const EdgeInsets.only(bottom: 10, top: 10),
          fillColor: AppColors.whiteColor,
          isDense: true,
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.appColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textfieldTextColor,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured; // Toggle password visibility
              });
            },
          ),
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
    );
  }
}
