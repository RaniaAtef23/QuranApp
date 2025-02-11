import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
class DateInfo extends StatelessWidget {
  final String? weekday;
  final String? meladeDate;
  final String? hijriDate;

  const DateInfo({super.key, this.weekday, this.meladeDate, this.hijriDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$weekday, $meladeDate",
          style: TextStyles.font16white400,
        ),
        SizedBox(height: 10.h),
        Text(
          "$hijriDate هجري",
          style: TextStyles.font16white400,
        ),
      ],
    );
  }
}