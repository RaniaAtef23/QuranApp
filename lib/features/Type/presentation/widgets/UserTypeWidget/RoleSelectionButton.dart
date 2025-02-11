import 'package:flutter/material.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/features/Type/presentation/NameInputPage.dart';
class RoleSelectionButton extends StatelessWidget {
  final String role;
  final IconData icon;
  final String email;

  const RoleSelectionButton({super.key, required this.role, required this.icon, required this.email});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: 1.05),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NameInputPage(userType: role, email: email),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: TextColors.darkBrown, width: 2.0),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28, color: TextColors.darkBrown),
                const SizedBox(width: 10),
                Text(
                  role,
                  style: const TextStyle(
                    fontFamily: 'NotoKufiArabic',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: TextColors.darkBrown,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
