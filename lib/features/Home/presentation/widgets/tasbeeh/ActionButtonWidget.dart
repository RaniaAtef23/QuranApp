import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Function() onIncrement;
  final Function() onReset;

  const ActionButtonsWidget({
    Key? key,
    required this.onIncrement,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Increment Button as Image
        GestureDetector(
          onTap: onIncrement,
          child: Image.asset(
            "assets/Home/islamic.png",
            height: 80,
            width: 80,
          ),
        ),
        // Reset Button as Image
        GestureDetector(
          onTap: onReset,
          child: Image.asset(
            "assets/Home/reload.png",
            height: 80,
            width: 80,
          ),
        ),
      ],
    );
  }
}
