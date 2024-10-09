import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/colour_picker_shape.dart';

class ColourPickerWidget extends StatelessWidget {
  ColourPickerWidget({super.key, this.backgroundColor, required this.onTap});
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SimpleDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: backgroundColor ?? AppColors.whiteColor,
        children: [
          SimpleDialogOption(
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Row(
                children: [
                  Image.asset('assets/icons/delete_icon.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Delete note',
                      style: GoogleFonts.roboto(
                          fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          SimpleDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: const Center(child: Text('Select Colour')),
            titleTextStyle: GoogleFonts.roboto(
                color: AppColors.blackColor,
                fontSize: 24,
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
                  itemBuilder: (context, index) =>
                      ColorPickerShape(choicecolors: choiceColors[index]),
                ),
              )
            ],
          ),
        ]);
  }
}
  // SimpleDialog(
  //           insetPadding: const EdgeInsets.all(0.0),
  //           title: const Center(child: Text('Select Colour')),
  //           titleTextStyle: GoogleFonts.roboto(
  //               color: AppColors.blackColor,
  //               fontSize: 24,
  //               fontWeight: FontWeight.w500),
  //           backgroundColor: backgroundColor ?? AppColors.whiteColor,
  //           contentPadding:
  //               const EdgeInsets.only(left: 29, right: 29, bottom: 10, top: 10),
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor1,
  //                         border: Border.all(
  //                           width: 1,
  //                         ),
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor2,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor3,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor4,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor5,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor6,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor7,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor8,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor9,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor10,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 10),
  //               child: Row(
  //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor11,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                   const SizedBox(
  //                     width: 18,
  //                   ),
  //                   Container(
  //                     width: width * 0.08,
  //                     height: height * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.choiceColor12,
  //                         borderRadius: BorderRadius.circular(30)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),