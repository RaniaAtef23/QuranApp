// onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/authentication/presentation/auth_screen.dart';
import 'package:quran_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return OnboardingWidget(
                title: data.title,
                subtitle: data.subtitle,
                image: data.image,
                onNext: _nextPage,
              );
            },
          ),
          Positioned(
            bottom: 75.h,
            left: 155.w,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the end (right)
              children: [
                Row(
                  children: List.generate(onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 12.h,
                      width: _currentPage == index ? 50.w : 12.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? const Color(0xFFA85000) :const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                    );
                  }).reversed.toList(), // Reverse the order of the indicators
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
