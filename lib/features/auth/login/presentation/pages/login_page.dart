import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/core/custom_widgets/auth_text_button.dart';
import 'package:habit_app/core/mixin/validation.dart';
import 'package:habit_app/features/auth/forget_password/presentation/pages/forget_password_page.dart';
import 'package:habit_app/core/custom_widgets/password_textffield.dart';
import 'package:habit_app/features/auth/login/presentation/authentication/auth_service_login.dart';
import 'package:habit_app/features/auth/signup/presentation/pages/signup_page.dart';
import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validation {
  late TextEditingController emailcontroller = TextEditingController();
  late TextEditingController passwordcontroller = TextEditingController();
  final AuthServiceLogin _authService = AuthServiceLogin();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // Initialize controllers in initState to keep them across rebuilds
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  Future<void> loginUser() async {
    // Validate form before proceeding with registration
    if (!_formKey.currentState!.validate()) return;

    // Get email and password from controllers
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text;

    User? user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      // Successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      // Display an error message if login failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Login failed. Wrong Email or password. Please check your credentials.')),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: AppTextField(
                                  hinttext: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      Validation.validateEmail(value),
                                  controller: emailcontroller,
                                  childPrefix: const Icon(
                                    Icons.email_outlined,
                                    color: AppColors.appColor,
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: PasswordTextField(
                                  controller: passwordcontroller,
                                  validator: (value) =>
                                      Validation.validatePassword(value),
                                  hintText: 'Password',
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
                AppButton(buttonText: 'LOG IN', onTap: () => loginUser()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
