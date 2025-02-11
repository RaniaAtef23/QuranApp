import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/widgets/back_button.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_cubit.dart';
import 'package:quran_app/features/Home/presentation/main_screen.dart';
import 'package:quran_app/features/Type/presentation/widgets/NameInputWidgets/AnimatedSubmitButton.dart';
import 'package:quran_app/features/Type/presentation/widgets/NameInputWidgets/NameInputField.dart';
import 'package:quran_app/features/Type/presentation/widgets/NameInputWidgets/back_button_widget.dart';
import 'package:quran_app/core/widgets/decorative_cycles.dart';
import 'package:quran_app/features/authentication/presentation/widgets/verify/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NameInputPage extends StatefulWidget {
  final String userType;
  final String email;

  const NameInputPage({super.key, required this.userType, required this.email});

  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _submitName(BuildContext context) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال اسمك')),
      );
      return;
    }

    _saveUserData(name, widget.userType, widget.email).then((_) {
      if (widget.userType == 'طالب') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Request()),
        );
      } else if (widget.userType == 'معلم') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  Future<void> _saveUserData(String userName, String userType, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userType', userType);
    await prefs.setString('userEmail', email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrayerCubit()..fetchPrayerData(),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              DecorativeCircles(),
              BackButton2(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'اسمك الكريم',
                            style: TextStyle(
                              fontFamily: 'NotoKufiArabic',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 300,
                            child: NameInputField(controller: _nameController),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 300,
                            child: AnimatedSubmitButton(onPressed: () => _submitName(context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}