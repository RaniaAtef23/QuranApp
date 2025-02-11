import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
class TitleSubtitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSubtitleSection({super.key, 
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Text(
          title,
          style: TextStyles.font32WhiteSemiBold,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: 30.h),
        SizedBox(
          width: 325.w,
          child: Text(
            subtitle,
            style: TextStyles.font22Whiteregular,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
