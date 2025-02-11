import 'package:flutter/material.dart';

class CounterDisplayWidget extends StatelessWidget {
  final int counter;

  const CounterDisplayWidget({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glowing Circular Progress
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xffa85000).withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: CircularProgressIndicator(
            value: counter / 100,
            strokeWidth: 12,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffa85000)),
            backgroundColor: Colors.white.withOpacity(0.5),
          ),
        ),
        // Counter Text
        Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "$counter / 100",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
