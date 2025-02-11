import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BackButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Center the back button horizontally
      children: [
        Padding(
          padding: EdgeInsets.only(top: 27.h),
          child: Container(
            width: 24.w, // Width set to 24
            height: 24.h, // Height set to 24
            decoration: BoxDecoration(
              border: Border.all(color: TextColors.darkBrown, width: 1), // Red border
              borderRadius: BorderRadius.circular(8.r), // Circular border with 12 radius
            ),
            child: Center( // Center the icon within the container
              child: InkWell(
                onTap: onTap,
                child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: 16.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
