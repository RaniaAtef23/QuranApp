import 'package:flutter/material.dart';
import 'package:quran_app/features/Quran_recitation/data/models/recitation.dart';
class RecitationItem extends StatelessWidget {
  final Recitation recitation;
  final Function(String) onTap;

  const RecitationItem({
    super.key,
    required this.recitation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(recitation.id.toString()),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.yellow.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade300.withOpacity(0.2),
              blurRadius: 10.0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recitation.title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'معرف التلاوة: ${recitation.id}',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.brown.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
