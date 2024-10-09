import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/core/custom_widgets/auth_text_button.dart';
import 'package:habit_app/features/auth/forget_password/presentation/widgets/password_textffield.dart';
import 'package:habit_app/features/auth/login/presentation/pages/login_page.dart';
import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AuthPageHeader(
                appbarTitle: 'Create Account',
                title: 'Let’s get to know you !',
                backgroundColor: AppColors.backgroundColor,
                subtitle: 'Enter your details to continue',
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: AppTextField(
                        hinttext: 'Display Name',
                        childPrefix: Icon(
                          Icons.person_outline,
                          color: AppColors.appColor,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: AppTextField(
                        hinttext: 'Email Address',
                        childPrefix: Icon(
                          Icons.email_outlined,
                          color: AppColors.appColor,
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: PasswordTextField(
                        hintText: 'Password',
                        suffix: Icon(
                          Icons.remove_red_eye_outlined,
                          color: AppColors.textfieldTextColor,
                        ),
                      )),
                  PasswordTextField(hintText: 'Confirm Password')
                ],
              ),
              AuthTextButton(
                subtitle: 'Login here',
                title: 'Already have an account?',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    // child: Text(
                    //   privacyPolicyterms,
                    //   style: GoogleFonts.roboto(
                    //     fontWeight: FontWeight.w300,
                    //     fontSize: 18,
                    //     color: AppColors.blackColor,
                    //   ),
                    // ),
                    child: Text.rich(
                      TextSpan(
                        text:
                            'By clicking the "CREATE ACCOUNT" button, you agree to ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: AppColors.blackColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of use',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: AppColors.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.blackColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AppButton(
                      buttonText: 'CREATE ACCOUNT',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardPage()),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
