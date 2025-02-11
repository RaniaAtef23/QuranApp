import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/onboardingButtons.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/titleSubtitle_widget.dart';
class OverlayContent extends StatelessWidget {
  final String title;
  final String subtitle;

  final VoidCallback onNext;

  const OverlayContent({super.key, 
    required this.title,
    required this.subtitle,

    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 359.h, left: 16.w, right: 16.w),
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              width: 358.w,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xBA000000),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                children: [
                  TitleSubtitleSection(
                    title: title,
                    subtitle: subtitle,
                  ),
                  SizedBox(height: 60.h),
                  ButtonRow(

                    onNext: onNext,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
