import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {super.key,
      required this.title,
      required this.content,
      this.elevation,
      this.color,
      required this.buttonText1,
      this.onPressed2,
      this.onPressed,
      required this.buttonText2});
  final String title;
  final String content;
  final double? elevation;
  final Color? color;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback? onPressed2;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    // double buttonWidth = MediaQuery.sizeOf(context).width;
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 19,
            fontFamily: 'Roboto',
            color: color ?? AppColors.blackColor,
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        content,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
            color: color ?? AppColors.greyColor,
            fontWeight: FontWeight.w400),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: AppColors.blackColor,
                            width: 3),
                        borderRadius: BorderRadius.circular(8.0)),
                    fixedSize: const Size(136, 42),
                  ),
                  child: Text(
                    buttonText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: color ?? AppColors.greyColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      // height: 19.2,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ElevatedButton(
                  onPressed: onPressed2,
                  style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColors.appColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    fixedSize: const WidgetStatePropertyAll(Size(136, 42)),
                  ),
                  child: Text(
                    buttonText2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: color ?? AppColors.whiteColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      // height: 19.2,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
