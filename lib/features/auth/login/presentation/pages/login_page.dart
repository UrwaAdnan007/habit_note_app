import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/core/custom_widgets/auth_text_button.dart';
import 'package:habit_app/features/auth/forget_password/presentation/pages/forget_password_page.dart';
import 'package:habit_app/features/auth/forget_password/presentation/widgets/password_textffield.dart';
import 'package:habit_app/features/auth/signup/presentation/pages/signup_page.dart';
import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  backgroundColor: AppColors.backgroundColor,
                  appbarTitle: 'Log In',
                  title: 'Welcome back !',
                  subtitle: 'Please login with your credentials',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    height: height * 0.35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: AppTextField(
                                hinttext: 'Email Address',
                                childPrefix: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.appColor,
                                )),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: PasswordTextField(
                                hintText: 'Password',
                                suffix: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: AppColors.textfieldTextColor,
                                ),
                              )),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordPage())),
                              child: const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppColors.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                  child: AuthTextButton(
                    subtitle: 'Create an account here',
                    title: 'Don’t have an account yet ?',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                AppButton(
                  buttonText: 'LOG IN',
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
