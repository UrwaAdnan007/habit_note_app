import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/features/auth/login/presentation/pages/login_page.dart';
import 'package:habit_app/features/auth/signup/presentation/pages/signup_page.dart';
import 'package:habit_app/features/onboarding/presentation/widgets/Slider_widget.dart';

class OnboardingMainPage extends StatefulWidget {
  const OnboardingMainPage({super.key});

  @override
  State<OnboardingMainPage> createState() => _OnboardingMainPageState();
}

class _OnboardingMainPageState extends State<OnboardingMainPage> {
  int _activePage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'text': 'WELCOME TO',
      'appName': 'HaBIT Note',
      'title': 'Take Notes',
      'subtitle': 'Quickly capture what’s on your mind',
      'image': 'assets/images/onboarding_one.png',
    },
    {
      'text': '',
      'appName': '',
      'title': 'To-dos',
      'subtitle': 'List out your day-to-day tasks',
      'image': 'assets/images/onboarding_two.png',
    },
    {
      'text': '',
      'appName': '',
      'title': 'Image to Text Converter',
      'subtitle': 'Upload your images and convert to text',
      'image': 'assets/images/onboarding_three.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.appColor),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: PageView.builder(
                itemCount: _pages.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return SliderWidget(
                    text: _pages[index]['text'],
                    title: _pages[index]['title'],
                    subtitle: _pages[index]['subtitle'],
                    image: _pages[index]['image'],
                    appName: _pages[index]['appName'],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      buttonText: 'CREATE ACCOUNT',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    AppButton(
                      buttonText: 'LOG IN',
                      color: AppColors.whiteColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if (_activePage == 0) {
      color = 'AppColors.appColor';
    } else if (_activePage == 1) {
      color = 'AppColors.appColor';
    } else {
      color = 'AppColors.appColor';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        height: 16,
        width: 65,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.appColor,
        ),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        curve: Curves.bounceOut,
        height: 16,
        width: 35,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
      ),
    );
  }
}
