import 'package:flutter/material.dart';
class QiblaBackground extends StatelessWidget {
  final Color mainColor;
  const QiblaBackground({Key? key, required this.mainColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor

      ),
    );
  }
}
