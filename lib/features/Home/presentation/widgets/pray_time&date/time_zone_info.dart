import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
class TimezoneInfo extends StatelessWidget {
  final String? timezone;

  const TimezoneInfo({super.key, this.timezone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(timezone ?? '', style: TextStyles.font16white500),
        ],
      ),
    );
  }
}