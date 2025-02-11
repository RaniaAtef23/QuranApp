import 'package:flutter/material.dart';

class RecitationTitle extends StatelessWidget {
  const RecitationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.orange.shade700),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back
            },
          ),
          Expanded(
            child: Text(
              'التلاوات القرءانية',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48.0), // Placeholder to balance the layout
        ],
      ),
    );
  }
}
