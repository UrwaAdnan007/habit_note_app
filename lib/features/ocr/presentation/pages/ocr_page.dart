import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/custom_dialog.dart';
import 'package:habit_app/core/custom_widgets/floating_button.dart';

class OcrPage extends StatelessWidget {
  const OcrPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppbarWidget(
            backgroundColor: AppColors.whiteColor,
            title: const Text(
              'Image to Text',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 26),
            ),
            // ignore: prefer_const_literals_to_create_immutables,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.copy_outlined))
            ],
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: SizedBox(
                                  width: 140,
                                  height: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Upload an image using the “+” button',
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          )),
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxHeight: 100, maxWidth: 250),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Click the “Scan Image” button to perform scan',
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 13,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            AppColors.whiteColor),
                                    fixedSize: WidgetStatePropertyAll(
                                        Size(width * 0.33, 40)),
                                    minimumSize: WidgetStatePropertyAll(
                                        Size(width * 0.33, 40)),
                                    elevation: const WidgetStatePropertyAll(1),
                                    shadowColor: const WidgetStatePropertyAll(
                                      Color.fromARGB(125, 50, 50, 71),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(50.0))),
                                  ),
                                  child: Text(
                                    'Clear Image',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: AppColors.blackColor,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                      // height: 19.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: AppButton(
                                  heightx: 40,
                                  fontSize: 17,
                                  widthx: width * 0.33,
                                  buttonText: 'Scan Image',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          floatingActionButton: FloatingButtonWidget(
            onTap: () => imagePickerDialog(context),
          ),
        ),
      ),
    );
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => MyCustomDialog(
              option1text: 'Take photo',
              option2text: 'Choose from gallery',
              option1Icon: 'assets/icons/photo_camera_icon.png',
              option2Icon: 'assets/icons/photo_icon.png',
              title: 'New',
              onTap1: () {},
              onTap2: () {},
            ));
  }
}
