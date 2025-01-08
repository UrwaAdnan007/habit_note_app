import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.childPrefix,
    this.maxlines,
    this.validator,
    this.controller,
    required this.hinttext,
    this.height,
    this.hinttextColor,
    this.onchanged,
    this.keyboardType,
  });
  final String hinttext;
  final Widget childPrefix;
  final ValueChanged? onchanged;
  final TextEditingController? controller;
  final double? height;
  final Color? hinttextColor;
  final FormFieldValidator? validator;
  final int? maxlines;
  final TextInputType? keyboardType;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            maxLines: widget.maxlines ?? 4,
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onchanged,
            style: GoogleFonts.roboto(
              color: AppColors.textfieldTextColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
            keyboardType: widget.keyboardType ?? TextInputType.name,
            decoration: InputDecoration(
              helperText: ' ',
              constraints:
                  BoxConstraints(maxHeight: widget.height ?? 65, minHeight: 65),
              contentPadding: const EdgeInsets.only(bottom: 10, top: 10),
              hintText: widget.hinttext,
              hintStyle: GoogleFonts.roboto(
                color: widget.hinttextColor ?? AppColors.textfieldTextColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: AppColors.whiteColor,
              isDense: true,
              prefixIcon: widget.childPrefix,
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
        ],
      ),
    );
  }
}
