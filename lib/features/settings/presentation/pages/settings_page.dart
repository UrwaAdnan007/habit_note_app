import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/settings/presentation/widgets/switch_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final String soundEffects = 'Sound effects';
  final String darkModeText = 'Dark Mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'Settings',
            style: GoogleFonts.roboto(
              color: AppColors.blackColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: AppColors.blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Column(
          children: [
            SwitchWidget(
              switchText: soundEffects,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SwitchWidget(
                switchText: darkModeText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
