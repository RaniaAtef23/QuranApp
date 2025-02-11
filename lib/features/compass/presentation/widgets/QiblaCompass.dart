import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QiblaCompass extends StatelessWidget {
  final Animation<double> needleRotationAnimation;

  const QiblaCompass({Key? key, required this.needleRotationAnimation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.white.withOpacity(0.1), Colors.brown.withOpacity(0.3)],
              center: Alignment.center,
              radius: 1.5,
            ),
          ),
          child: SvgPicture.asset(
            'assets/qiblah/compass.svg',
            width: 350,
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
        AnimatedBuilder(
          animation: needleRotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: needleRotationAnimation.value * pi / 180,
              child: SvgPicture.asset(
                'assets/qiblah/needle.svg',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ],
    );
  }
}
