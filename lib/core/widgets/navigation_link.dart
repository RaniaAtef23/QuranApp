import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';

class NavigationLink extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onPressed;

  const NavigationLink({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Align to the left
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align items to the start
          children: [
            Text(
              actionText,
              style: TextStyles.font14darkbrownRegular,
            ),
            SizedBox(width: 4.w),
            Padding(
              padding:  EdgeInsets.only(left: 7.w),
              child: Text(
                questionText,
                style: TextStyles.font14darkbrownRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
