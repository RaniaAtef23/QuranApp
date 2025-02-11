import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
class SocialLoginButton extends StatelessWidget {
  final String imagePath;

  final VoidCallback? onPressed;

  const SocialLoginButton({
    super.key,
    required this.imagePath,

    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0.r),
          border: Border.all(color:TextColors.light2grey),
        ),
        child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Image.network(imagePath)),
            ),



      ),
    );
  }
}