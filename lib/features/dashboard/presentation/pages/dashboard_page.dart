import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/about_me/presentation/pages/about_me_page.dart';
import 'package:habit_app/features/help/presentation/pages/help_page.dart';
import 'package:habit_app/features/note_editor/presentation/pages/note_editor_page.dart';
import 'package:habit_app/features/ocr/presentation/pages/ocr_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    const NoteEditorPage(),
    const OcrPage(),
    const HelpPage(),
    const AboutMePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backgroundColor,
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 30, child: Image.asset('assets/icons/note.png')),
                  label: 'Notes'),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 30, child: Image.asset('assets/icons/ocr.png')),
                  label: 'OCR'),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 30, child: Image.asset('assets/icons/help.png')),
                  label: 'Help'),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 30, child: Image.asset('assets/icons/me.png')),
                  label: 'Me'),
            ],
            iconSize: 20,

            elevation: 2,
            selectedItemColor: AppColors.textfieldTextColor,
            unselectedItemColor: AppColors.blackColor,
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400),
            selectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
