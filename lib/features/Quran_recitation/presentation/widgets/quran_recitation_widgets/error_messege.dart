import 'package:flutter/material.dart';
class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textDirection: TextDirection.rtl,
        style: const TextStyle(color: Colors.red, fontSize: 16.0),
      ),
    );
  }
}
