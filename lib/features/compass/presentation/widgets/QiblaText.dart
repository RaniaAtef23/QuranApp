import 'package:flutter/material.dart';

class QiblaText extends StatelessWidget {
  final double? qiblaDirection;

  const QiblaText({Key? key, this.qiblaDirection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return qiblaDirection == null
        ? CircularProgressIndicator(color: Colors.white)
        : Text(
      "اتجاه القبلة: ${qiblaDirection!.toStringAsFixed(2)}°",
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
    );
  }
}
