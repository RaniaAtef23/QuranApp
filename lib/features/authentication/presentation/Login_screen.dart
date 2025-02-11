import 'package:flutter/material.dart';
import 'package:quran_app/features/authentication/presentation/widgets/login/login_body.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: LoginBody()
      ),
    );
  }
}
