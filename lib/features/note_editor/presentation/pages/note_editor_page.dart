import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/custom_dialog.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/drawer_widget.dart';
import 'package:habit_app/core/custom_widgets/floating_button.dart';
import 'package:habit_app/features/add_note/presentation/pages/note_page.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/filter_by_colour_widget.dart';
import 'package:habit_app/features/todo/presentation/pages/todo_page.dart';

class NoteEditorPage extends StatelessWidget {
  const NoteEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppbarWidget(
              iconTheme: const IconThemeData(color: AppColors.appColor),
              backgroundColor: AppColors.whiteColor,
              title: Text(
                'Notes',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 26),
              ),
              // ignore: prefer_const_literals_to_create_immutables,
              actions: [
                IconButton(
                    onPressed: () => filterByColour(context),
                    icon: Image.asset('assets/icons/color_lens.png')),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/gridview_icon.png')),
                )
              ],
              automaticallyImplyLeading: true,
            ),
            backgroundColor: AppColors.whiteColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/note_editor_bgimg.png'),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Create your first note !',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              color: AppColors.blackColor),
                        ),
                      ),
                    ],
                  )),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: FloatingButtonWidget(
                onTap: () => newNoteDialog(context),
              ),
            )));
  }

  void newNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MyCustomDialog(
        option1text: 'Add note',
        option2text: 'Add to-do',
        option1Icon: 'assets/icons/keyboard_icon.png',
        option2Icon: 'assets/icons/checkbox_icon.png',
        title: 'New',
        onTap1: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotePage()),
        ),
        onTap2: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ToDoPage()),
        ),
      ),
    );
  }

  void filterByColour(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => FilterByColourWidget(
              onTap: () {},
            ));
  }
}
