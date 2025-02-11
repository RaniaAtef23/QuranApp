import 'package:flutter/material.dart';
class BackButton2 extends StatelessWidget {
  const BackButton2();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}