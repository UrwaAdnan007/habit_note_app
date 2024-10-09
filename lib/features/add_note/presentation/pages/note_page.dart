import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/color_picker_widget.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarWidget(
        backgroundColor: AppColors.whiteColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Add Note'),
        ),
        titleTextStyle: GoogleFonts.roboto(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 24),
        leading: Transform.translate(
          offset: const Offset(20.0, 0.0),
          child: BackButton(
            color: AppColors.appColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 41.0),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.nunito(
                              fontSize: 35, fontWeight: FontWeight.w400),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Title',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 48, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.nunito(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type something...',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 23, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      buttonText: 'Add Note',
                      onTap: () => colourPicker(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void colourPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ColourPickerWidget(
              onTap: () {},
            ));
  }
}
