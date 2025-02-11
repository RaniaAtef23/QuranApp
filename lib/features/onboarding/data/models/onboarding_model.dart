// onboarding_model.dart

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

// Sample onboarding data
final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    title: "مرحباً!",
    subtitle: "ابدأ رحلتك في حفظ القرآن بسهولة وبالوتيرة التي تناسبك.",
    image: "assets/OnBoarding/onboarding.png",
  ),
  OnboardingModel(
    title: "خطط مخصصة",
    subtitle: "ضع أهدافك الخاصة وتلقَّ تذكيرات مخصصة لتبقى على المسار.",
    image: "assets/OnBoarding/onboarding2.png",
  ),
  OnboardingModel(
    title: "حافظ على التحفيز",
    subtitle: "استلم تذكيرات يومية وآيات ملهمة تبقيك متصلاً بالقرآن.",
    image: "assets/OnBoarding/onboarding3.png",
  ),
];
