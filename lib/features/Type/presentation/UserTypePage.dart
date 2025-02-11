import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/widgets/decorative_cycles.dart';
import 'package:quran_app/features/Type/presentation/widgets/UserTypeWidget/CustomAppbar.dart';
import 'package:quran_app/features/Type/presentation/widgets/UserTypeWidget/RoleSelectionButton.dart';
import 'package:quran_app/features/Type/presentation/widgets/UserTypeWidget/TitleText.dart';

class UserTypePage extends StatelessWidget {
  final String email;

  const UserTypePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         DecorativeCircles(),
          Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TitleText(),
                      const SizedBox(height: 40),
                      RoleSelectionButton(role: 'معلم', icon: Icons.school, email: email),
                      SizedBox(height: 20.h),
                      RoleSelectionButton(role: 'طالب', icon: Icons.person, email: email),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





