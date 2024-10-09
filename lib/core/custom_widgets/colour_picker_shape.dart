import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class ColorPickerShape extends StatelessWidget {
  ColorPickerShape({super.key, required this.choicecolors});
  final Color choicecolors;
  Color currentColor = AppColors.choiceColor1;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: choicecolors,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 210),
              opacity: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.blackColor, width: 1)),
              ),
            ),
          ),
        ));
  }
}
