import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget(
      {super.key,
      required this.onTap,
      this.heightx,
      this.widthx,
      this.color,
      this.iconColor,
      this.icon});
  final double? widthx;
  final double? heightx;
  final Color? color;
  final Color? iconColor;
  final Icon? icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widthx ?? 60,
        height: heightx ?? 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? AppColors.appColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(-5, 0), // changes position of shadow
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ]),
        child: Icon(
          Icons.add_rounded,
          color: iconColor ?? AppColors.whiteColor,
          size: 48,
        ),
      ),
    );
  }
}
