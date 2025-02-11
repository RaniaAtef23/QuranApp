import 'package:flutter/material.dart';
import 'package:quran_app/core/resources/colors.dart';
class DecorativeCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TextColors.darkBrown,
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TextColors.darkBrown,
            ),
          ),
        ),
      ],
    );
  }
}