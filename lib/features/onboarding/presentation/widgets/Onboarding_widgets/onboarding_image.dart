import 'package:flutter/material.dart';
class BackgroundImage extends StatelessWidget {
  final String imageUrl;

  const BackgroundImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
