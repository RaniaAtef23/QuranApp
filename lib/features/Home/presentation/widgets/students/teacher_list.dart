import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_profile.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_provider.dart';

class TeacherList extends StatelessWidget {
  final String? studentName;
  final String?email;

  const TeacherList({super.key, this.studentName, this.email});

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);
    final teachers = teacherProvider.teachers.entries.toList(); // Extracts key-value pairs


    if (teachers.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد معلمين متاحين',
          style: TextStyle(
            fontFamily: 'NotoKufiArabic',
            fontSize: 18.sp,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return SizedBox(
      height: 190.h, // Fixed height for the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return _buildTeacherCard(context, teachers[index].key,teachers[index].value); // Pass context and teacher name
        },
      ),
    );
  }

  Widget _buildTeacherCard(BuildContext context, String teacherName,String teacherEmail) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherProfile(
              username: teacherName,
              studentName: studentName,
              email: teacherEmail,
            ),
          ),
        );
      },
      child: Container(
        width: 165.w,
        margin: EdgeInsets.symmetric(horizontal: 16.w), // Add horizontal margin
        decoration: BoxDecoration(
          color: TextColors.darkBrown, // Use a color similar to TextColors.darkBrown
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Teacher Image
            ClipRRect(

              child: Image.asset(
                'assets/Home/student_image.png', // Use Image.asset for local assets
                width: 100.h,
                height: 100.h,
                fit: BoxFit.cover, // Ensure the image covers the area
              ),
            ),
            // Teacher Details
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h), // Add padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Teacher Name
                    Text(
                      teacherName,
                      style: TextStyles.font16blue400Regular,
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                    SizedBox(height: 4.h),
                    // Role Label
                    Text(
                      'معلم',
                      style: TextStyles.font12grey4002regular,
                      textAlign: TextAlign.right, // Align text to the right // Align text to the right
                    ),
                    // Details Button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeacherProfile(
                              username: teacherName,
                              studentName: studentName,
                              email: email,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 72.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: TextColors.darkBrown, // Use a color similar to TextColors.darkBrown
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Text(
                            "كل التفاصيل",
                            style: TextStyles.font12white400regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}