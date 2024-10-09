import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class ColorFilterShape extends StatelessWidget {
  ColorFilterShape({super.key, required this.choicecolors});
  final Color choicecolors;
  Color currentColor = AppColors.choiceColor1;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: choicecolors, borderRadius: BorderRadius.circular(30)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(30),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 210),
              opacity: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.blackColor, width: 1)),
              ),
            ),
          ),
        ));
  }
}
