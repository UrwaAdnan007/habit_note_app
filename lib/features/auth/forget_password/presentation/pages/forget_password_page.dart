import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AuthPageHeader(
                  appbarTitle: 'Forgot Password',
                  backgroundColor: AppColors.backgroundColor,
                  title: '',
                  subtitle:
                      'Please enter your account’s email address and we will send you a link to reset your password.',
                ),
                SizedBox(
                  height: height * 0.30,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: AppTextField(
                        hinttext: 'Email Address',
                        childPrefix: Icon(
                          Icons.email_outlined,
                          color: AppColors.appColor,
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.25,
                ),
                AppButton(
                  buttonText: 'SUBMIT',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardPage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
