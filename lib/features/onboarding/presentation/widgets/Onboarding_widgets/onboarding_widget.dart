import 'package:flutter/material.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/onboardingContent.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/onboarding_image.dart';
class OnboardingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onNext;

  const OnboardingWidget({super.key, 
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(imageUrl: image),
        OverlayContent(
          title: title,
          subtitle: subtitle,
          onNext: onNext,
        ),
      ],
    );
  }
}
