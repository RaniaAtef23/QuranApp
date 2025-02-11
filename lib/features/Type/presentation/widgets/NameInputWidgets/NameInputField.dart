import 'package:flutter/material.dart';
class NameInputField extends StatelessWidget {
  final TextEditingController controller;

  const NameInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'NotoKufiArabic',
          fontSize: 20,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintText: 'اكتب اسمك هنا',
          hintStyle: TextStyle(
            fontFamily: 'NotoKufiArabic',
            fontSize: 18,
            color: Colors.black.withOpacity(0.6),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }
}