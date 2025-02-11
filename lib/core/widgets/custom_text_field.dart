import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 358.w, // Fixed width
          height: 38.h, // Fixed height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r), // Consistent border radius
          ),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.font14lightgreyRegular,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r), // Consistent border radius
                borderSide: const BorderSide(
                  width: 1.0,
                  color: TextColors.lightGrey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: TextColors.lightGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: TextColors.darkBrown,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
                vertical: 8.0.h, // Consistent vertical padding
              ),
            ),
            obscureText: _isObscured,
            validator: widget.validator,
            cursorColor: TextColors.darkBrown,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
