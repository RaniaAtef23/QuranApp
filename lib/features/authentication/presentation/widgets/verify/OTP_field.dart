import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';

class OtpDigitField extends StatefulWidget {
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final double fieldWidth;

  const OtpDigitField({
    super.key,
    required this.currentFocus,
    this.nextFocus,
    required this.fieldWidth,
  });

  @override
  OtpDigitFieldState createState() => OtpDigitFieldState();
}

class OtpDigitFieldState extends State<OtpDigitField> {
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: widget.fieldWidth * 0.1),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: _inputValue.isNotEmpty ? Colors.white : TextColors.lightblue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            focusNode: widget.currentFocus,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.fieldWidth * 0.6,
              height: 1.5,
            ),
            keyboardType: TextInputType.number,
            maxLength: 1,
            cursorColor: TextColors.darkBrown, // Set cursor color to brown
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: _inputValue.isNotEmpty
                      ? TextColors.darkBrown
                      : TextColors.lightblue,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: _inputValue.isNotEmpty
                      ? TextColors.darkBrown
                      : TextColors.lightblue,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: _inputValue.isNotEmpty
                      ? TextColors.darkBrown
                      : TextColors.lightblue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.only(bottom: 8),
              counterText: '',
              counterStyle: TextStyles.font24blackBold,
            ),
            controller: TextEditingController(text: _inputValue)
              ..selection = TextSelection.fromPosition(
                  TextPosition(offset: _inputValue.length)),
            onChanged: (value) {
              if (value.length <= 1) {
                setState(() {
                  _inputValue = value; // Update state
                });
                if (value.length == 1 && widget.nextFocus != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocus);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
