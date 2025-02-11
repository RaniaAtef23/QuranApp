import 'package:flutter/material.dart';
class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'هل انت ..؟',
      style: TextStyle(
        fontFamily: 'NotoKufiArabic',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}