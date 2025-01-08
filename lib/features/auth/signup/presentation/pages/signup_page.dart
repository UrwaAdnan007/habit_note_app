import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/app_textfield.dart';
import 'package:habit_app/core/custom_widgets/auth_page_header.dart';
import 'package:habit_app/core/custom_widgets/auth_text_button.dart';
import 'package:habit_app/core/mixin/validation.dart';
import 'package:habit_app/core/custom_widgets/password_textffield.dart';
import 'package:habit_app/features/auth/login/presentation/pages/login_page.dart';
import 'package:habit_app/features/auth/signup/presentation/auth_service/auth_service_signup.dart';

import 'package:habit_app/features/dashboard/presentation/pages/dashboard_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with Validation {
  final AuthServiceSignup _authService = AuthServiceSignup();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namecontroller = TextEditingController();
  late TextEditingController controlleremail = TextEditingController();
  late TextEditingController controllerpassword = TextEditingController();
  late TextEditingController confirmpasswordcontroller =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers in initState to keep them across rebuilds
    controlleremail = TextEditingController();
    controllerpassword = TextEditingController();
    namecontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    controlleremail.dispose();
    controllerpassword.dispose();
    confirmpasswordcontroller.dispose();
  }

  Future<void> registerUser() async {
    // Validate form before proceeding with registration
    if (!_formKey.currentState!.validate()) return;

    // Get email and password from controllers
    String email = controlleremail.text.trim();
    String password = controllerpassword.text;
    String name = namecontroller.text.trim();
    User? user = await _authService.createUserWithEmailAndPassword(
        email, password, name);
    if (user != null) {
      log('User created successfully with UID: ${user.uid}');
      // Navigate to the dashboard or home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      log('User creation failed');
    }
  }

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
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: AppTextField(
                        hinttext: 'Display Name',
                        controller: namecontroller,
                        validator: (value) =>
                            Validation.validateEmptyField(value),
                        childPrefix: const Icon(
                          Icons.person_outline,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                    AppTextField(
                        validator: (value) => Validation.validateEmail(value),
                        controller: controlleremail,
                        hinttext: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        childPrefix: const Icon(
                          Icons.email_outlined,
                          color: AppColors.appColor,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: PasswordTextField(
                          controller: controllerpassword,
                          hintText: 'Password',
                          validator: (value) =>
                              Validation.validatePassword(value),
                        )),
                    PasswordTextField(
                      hintText: 'Confirm Password',
                      controller: confirmpasswordcontroller,
                      validator: (value) => validateConfirmPassword(
                          controllerpassword.text, value),
                    )
                  ],
                ),
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
                      onTap: () => registerUser(),
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
