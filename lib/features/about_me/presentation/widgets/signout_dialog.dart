import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/features/about_me/presentation/authentication/authentication_logout.dart';
import 'package:habit_app/features/onboarding/presentation/pages/onboarding_main_page.dart';

class SignoutDialogWidget extends StatefulWidget {
  const SignoutDialogWidget({
    super.key,
    this.elevation,
    this.color,
  });
  final double? elevation;
  final Color? color;

  @override
  State<SignoutDialogWidget> createState() => _SignoutDialogWidgetState();
}

class _SignoutDialogWidgetState extends State<SignoutDialogWidget> {
  final AuthServiceLogout _authServiceLogout = AuthServiceLogout();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        'Log out',
        style: TextStyle(
            fontSize: 19,
            fontFamily: 'Roboto',
            color: widget.color ?? AppColors.blackColor,
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
            color: widget.color ?? AppColors.greyColor,
            fontWeight: FontWeight.w400),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: AppColors.blackColor,
                          width: 3),
                      borderRadius: BorderRadius.circular(8.0)),
                  fixedSize: const Size(115, 42),
                ),
                child: Text(
                  'No',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: widget.color ?? AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  await _signOutUser(context); // Proceed with sign-out
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.appColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  fixedSize: MaterialStateProperty.all(const Size(115, 42)),
                ),
                child: Text(
                  'Log out',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: widget.color ?? AppColors.whiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _signOutUser(BuildContext context) async {
    try {
      await _authServiceLogout.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingMainPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }
}
