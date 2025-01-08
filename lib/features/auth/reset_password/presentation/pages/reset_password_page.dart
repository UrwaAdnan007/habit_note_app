import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/core/mixin/validation.dart';
import 'package:habit_app/features/auth/reset_password/presentation/authentication/authentication_reset_password.dart';
import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with Validation {
  final TextEditingController _emailController = TextEditingController();
  final AuthServiceResetPassword _authServiceResetPassword =
      AuthServiceResetPassword();
  final _formKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) return;
    String email = _emailController.text.trim();
    try {
      await _authServiceResetPassword.sendPasswordResetEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
      Navigator.pop(context); // Go back to login page
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email';
        } else {
          errorMessage =
              'An error occurred: ${e.message ?? "Please try again"}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
      // Show error message directly to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('An unknown error occurred. Please try again later.')),
      );
    }
  }

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
                  appbarTitle: 'Reset Password',
                  backgroundColor: AppColors.backgroundColor,
                  title: '',
                  subtitle:
                      'Please enter your account’s email address and we will send you a link to reset your password.',
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: height * 0.30,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) => Validation.validateEmail(value),
                          hinttext: 'Email Address',
                          childPrefix: const Icon(
                            Icons.email_outlined,
                            color: AppColors.appColor,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.25,
                ),
                AppButton(
                    buttonText: 'SUBMIT',
                    onTap: () => sendPasswordResetEmail()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
