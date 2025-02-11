import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
class FeatureIcon extends StatelessWidget {
  final String assetPath;
  final String label;

  const FeatureIcon({super.key, required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: TextColors.darkbrown2,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(child: Image.network(assetPath)),
        ),
        SizedBox(height: 5.h),
        Text(label, style: TextStyles.font16darkbrown500),
      ],
    );
  }
}