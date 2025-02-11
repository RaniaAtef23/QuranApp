import 'package:flutter/material.dart';
import 'package:quran_app/core/resources/colors.dart';
class AnimatedSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AnimatedSubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: 1.05),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: TextColors.darkBrown,
                  width: 2.0,
                ),
              ),
              elevation: 0,
            ),
            child: Text(
              'تأكيد',
              style: TextStyle(
                fontFamily: 'NotoKufiArabic',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TextColors.darkBrown,
              ),
            ),
          ),
        );
      },
    );
  }
}