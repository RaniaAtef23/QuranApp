import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width; // Width parameter
  final double? height; // Height parameter
  final double? radius; // Radius parameter
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 327,
    this.height,
    this.textStyle,
    this.radius, // Default radius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:358.w, // Use the provided width
      height: height ?? 46.h,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(//Color(0xCCA85000)
              colors: [Color(0xCCA85000),Color(0xCC522700)], // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 33.r),
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle ?? TextStyles.font18whitesemiBold,
            ),
          ),
        ),
      ),
    );
  }
}
