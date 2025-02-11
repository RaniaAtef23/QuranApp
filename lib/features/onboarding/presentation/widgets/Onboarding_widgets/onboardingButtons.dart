import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
class ButtonRow extends StatelessWidget {

  final VoidCallback onNext;

  const ButtonRow({super.key, 

    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: (){
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: TextColors.lightGrey,
                width: 2.0,
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'تخطي',
                style: TextStyles.font20lightGreyRegular,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: OutlinedButton(
            onPressed: onNext,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: TextColors.darkBrown,
                width: 2.0,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'متابعة',
                style: TextStyles.font20darkBrownRegular,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
