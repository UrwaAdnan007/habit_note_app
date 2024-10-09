import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/color_picker_widget.dart';
import 'package:habit_app/features/todo/presentation/widgets/todo_item.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarWidget(
        backgroundColor: AppColors.whiteColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Add To-do'),
        ),
        titleTextStyle: const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: height * 0.1,
                          child: ListTile(
                            horizontalTitleGap: 12,
                            contentPadding: const EdgeInsets.only(left: 0),
                            leading: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.black26,
                                )),
                            title: const TextField(
                              autofocus: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Type something...',
                                hintStyle: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.9,
                        child: ListView.builder(
                          itemCount: 3,
                          itemExtent: 40,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => const ToDoItem(),
                        ),
                      )
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
