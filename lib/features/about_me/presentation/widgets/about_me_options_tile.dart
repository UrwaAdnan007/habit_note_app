import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class AboutMeOptionsTile extends StatelessWidget {
  const AboutMeOptionsTile({
    super.key,
    this.onTapArchiveNotes,
    this.onTapSettings,
    this.onTapAbout,
    this.onTapResetPassword,
  });
  final VoidCallback? onTapArchiveNotes;
  final VoidCallback? onTapSettings;
  final VoidCallback? onTapAbout;
  final VoidCallback? onTapResetPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          ListTile(
              minTileHeight: 40,
              onTap: onTapResetPassword,
              title: const Text(
                "Reset Password",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(
                Icons.lock,
                color: AppColors.blackColor,
              )),
          ListTile(
              minTileHeight: 40,
              onTap: onTapAbout,
              title: const Text(
                "About",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(
                Icons.info,
                color: AppColors.blackColor,
              )),
        ],
      ),
    );
  }
}
