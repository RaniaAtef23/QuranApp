import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/features/authentication/presentation/widgets/login/login_widget.dart';
import 'package:quran_app/features/authentication/presentation/widgets/sign_up/signUp_widget.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool _userExists = false;

  @override
  void initState() {
    super.initState();
    _checkUserExists();
  }

  Future<void> _checkUserExists() async {
    final prefs = await SharedPreferences.getInstance();
    final existingUser = prefs.getString('user_email'); // Checking if user is stored

    if (existingUser != null) {
      setState(() {
        _userExists = true;
      });

      // Show a notification asking the user to log in
      Future.delayed(Duration.zero, () {
        _showUserExistsDialog();
      });
    }
  }

  void _showUserExistsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Account Exists'),
          content: const Text('You already have an account. Please log in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToLogin();
              },
              child: const Text('Login'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to right-to-left
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!_userExists) const SignupWidget(), // Show Signup if no user exists
            if (_userExists)
              Column(
                children: [
                  const Text('You already have an account.'),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: _navigateToLogin,
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
