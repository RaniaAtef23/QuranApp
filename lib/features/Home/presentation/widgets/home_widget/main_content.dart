import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/Home/presentation/widgets/home_widget/TeacherListSection.dart';
import 'package:quran_app/features/Home/presentation/widgets/home_widget/_FeatureIconRow.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/hadeth_container.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/verse_container.dart';
class MainContent extends StatelessWidget {
  final String userType;
  final String? studentName;
  final String email;

  const MainContent({
    required this.userType,
    required this.studentName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        FeatureIconsRow(),
        TeacherListSection(studentName: studentName, email: email, userType: userType),
        SizedBox(height: 20.h),
        const VerseContainer(),
        SizedBox(height: 20.h),
        const HadethContainer(),
        SizedBox(height: 20.h),
      ],
    );
  }
}