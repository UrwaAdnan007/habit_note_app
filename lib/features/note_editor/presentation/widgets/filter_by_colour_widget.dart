import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/color_filter_shape.dart';

class FilterByColourWidget extends StatelessWidget {
  FilterByColourWidget({super.key, required this.onTap, this.backgroundColor});

  final VoidCallback onTap;
  final Color? backgroundColor;
  List<Color> choiceColors = [
    AppColors.choiceColor1,
    AppColors.choiceColor2,
    AppColors.choiceColor3,
    AppColors.choiceColor4,
    AppColors.choiceColor5,
    AppColors.choiceColor6,
    AppColors.choiceColor7,
    AppColors.choiceColor8,
    AppColors.choiceColor9,
    AppColors.choiceColor10,
    AppColors.choiceColor11,
    AppColors.choiceColor12,
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('Filter by colour'),
      elevation: 4,
      titleTextStyle: GoogleFonts.roboto(
          color: AppColors.blackColor,
          fontSize: 24,
          fontWeight: FontWeight.w400),
      titlePadding: const EdgeInsets.only(
        left: 29,
        top: 29,
      ),
      backgroundColor: backgroundColor ?? AppColors.whiteColor,
      contentPadding:
          const EdgeInsets.only(left: 29, right: 29, bottom: 60, top: 29),
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width * 0.002,
            height: height * 0.05,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: const Text(
              'Reset',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        SizedBox(
          width: 300,
          height: 240,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (width / (height / 4.5)),
              crossAxisSpacing: 12,
              mainAxisSpacing: 22,
            ),
            itemCount: choiceColors.length,
            itemBuilder: (context, index) =>
                ColorFilterShape(choicecolors: choiceColors[index]),
          ),
        )
      ],
    );
  }
}
