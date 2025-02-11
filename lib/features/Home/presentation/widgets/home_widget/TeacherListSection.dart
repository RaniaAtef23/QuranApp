import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_list.dart';
class TeacherListSection extends StatelessWidget {
  final String? studentName;
  final String email;
  final String userType;

  const TeacherListSection({
    required this.studentName,
    required this.email,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 16.sp, color: TextColors.darkBrown, weight: 500.w),
                  Text("عرض الكل", style: TextStyles.font16darkbrownMedium),
                ],
              ),
              Text(userType == "معلم" ? "المعلمين" : "المعلمين", style: TextStyles.font20grey500Medium),
            ],
          ),
        ),
        TeacherList(studentName: studentName, email: userType == "معلم" ? email : ""),
      ],
    );
  }
}