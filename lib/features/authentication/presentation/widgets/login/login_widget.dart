import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/widgets/social_login_buttons.dart';
import 'package:quran_app/features/authentication/presentation/widgets/login/login_form.dart';
import 'package:quran_app/features/authentication/presentation/widgets/verify/request.dart';
class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final bool _agreeToTerms = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _login() {
    // You can call the _login function in LoginForm via the onLogin callback
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          LoginForm(
            onLogin: _login,
          ),
          SizedBox(height: 8.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SocialLoginButton(
                imagePath: 'assets/login/google.png',

              ),
              SizedBox(width: 10.0.h),
              const SocialLoginButton(
                imagePath: 'assets/login/facebook.png',

              ),
              SizedBox(width: 10.0.h),
              const SocialLoginButton(
                imagePath: 'assets/login/apple.png',
              ),
            ],
          ),

        ],

    );
  }
}