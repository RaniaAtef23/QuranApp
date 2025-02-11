import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/widgets/social_login_buttons.dart';
import 'package:quran_app/features/authentication/presentation/Login_screen.dart';
import 'package:quran_app/features/authentication/presentation/widgets/sign_up/signUp_form.dart';
class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  SignupWidgetState createState() => SignupWidgetState();
}

class SignupWidgetState extends State<SignupWidget> {
  bool _agreeToTerms = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _Signup() {

  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
       SignupForm(
         onSignup:_Signup,
         agreeToTerms: _agreeToTerms,
         onAgreeToTermsChanged: (value) {
           setState(() {
             _agreeToTerms = value ?? false;
           });
         },
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