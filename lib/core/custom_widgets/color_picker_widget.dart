import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/colour_picker_shape.dart';

class ColourPickerWidget extends StatelessWidget {
  ColourPickerWidget({
    super.key,
    this.backgroundColor,
    required this.onColorSelected,
  });
  final ValueChanged<Color> onColorSelected;

  final Color? backgroundColor;

  final List<Color> choiceColors = [
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SimpleDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: backgroundColor ?? AppColors.whiteColor,
        children: [
          SimpleDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: const Center(child: Text('Select Colour')),
            titleTextStyle: GoogleFonts.roboto(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.w500),
            backgroundColor: backgroundColor ?? AppColors.whiteColor,
            contentPadding:
                const EdgeInsets.only(left: 29, right: 29, bottom: 10, top: 10),
            children: <Widget>[
              SizedBox(
                width: 310,
                height: 160,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: (width / (height / 2.0)),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: choiceColors.length,
                  itemBuilder: (context, index) {
                    return ColorPickerShape(
                      choicecolors: choiceColors[index],
                      onTap: () {
                        // Send the selected color back to the parent widget
                        onColorSelected(choiceColors[index]);
                        Navigator.of(context).pop(); // Close the picker dialog
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ]);
  }
}
