import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


class TimeWidget extends StatelessWidget {
  final String label;
  final DateTime selectedTime;
  final Function(DateTime) onTimeChange;

  const TimeWidget({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        TimePickerSpinner(
          is24HourMode: false,
          normalTextStyle: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          highlightedTextStyle: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w500,
            color: const Color(0xff303030),
          ),
          spacing: screenWidth * 0.05,
          itemHeight: screenWidth * 0.1,
          isForce2Digits: true,
          alignment: Alignment.center,
          onTimeChange: onTimeChange,
          time: selectedTime,
        ),
      ],
    );
  }
}