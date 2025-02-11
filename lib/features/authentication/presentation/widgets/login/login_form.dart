import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/validator.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/core/widgets/custom_button.dart';
import 'package:quran_app/core/widgets/custom_text_field.dart';
import 'package:quran_app/core/widgets/navigation_link.dart';
import 'package:quran_app/features/Type/presentation/UserTypePage.dart';
import 'package:quran_app/features/authentication/data/shared_preference.dart';
import 'package:quran_app/features/authentication/presentation/forget_pass_screen.dart';

class LoginForm extends StatefulWidget {
  final Function? onLogin;
  final Function(bool)? onCheckboxChanged;

  const LoginForm({
    super.key,
    this.onLogin,
    this.onCheckboxChanged,
  });

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();

      // Retrieve the list of registered emails from SharedPreferences
      final registeredEmails = await SharedPrefsService.getRegisteredEmails();

      // Check if the email exists in the list
      if (!registeredEmails.contains(email)) {
        // Show an alert dialog if the email does not exist
        _showEmailNotExistDialog();
      } else {
        // Proceed with login if the email exists
        if (widget.onLogin != null) {
          widget.onLogin!();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserTypePage(email: email), // Pass email here
          ),
        );
      }
    }
  }


  void _showEmailNotExistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60.w,
                  color: Colors.red,
                ),
                SizedBox(height: 20.h),
                Text(
                  "البريد الإلكتروني غير موجود",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "البريد الإلكتروني الذي أدخلته غير موجود. الرجاء إنشاء حساب جديد.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'إنشاء حساب',
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    // Navigate to the signup screen or perform signup logic
                  },
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  text: 'حسناً',
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                "البريد الالكتروني",
                style: TextStyles.font16blackMedium,
              ),
            ),
            SizedBox(height: 5.h),
            Center(
              child: CustomTextField(
                hintText: 'ادخل بريدك الالكتروني',
                controller: _emailController,
                validator: Validator.emailValidator,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                "كلمة المرور",
                style: TextStyles.font16blackMedium,
              ),
            ),
            SizedBox(height: 5.h),
            Center(
              child: CustomTextField(
                hintText: 'ادخل كلمة المرور',
                isPassword: true,
                controller: _passwordController,
                validator: Validator.loginPasswordValidator,
              ),
            ),
            const SizedBox(height: 8.0),
            NavigationLink(
              questionText: "",
              actionText: "نسيت كلمة المرور؟",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgetPasswordScreen(),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: CustomButton(
                text: 'تسجيل الدخول',
                onPressed: _login,
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Text(
                "خيارات تسجيل الدخول الأخرى",
                style: TextStyles.font14blackRegular,
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(height: 8.0.h),
          ],
        ),
      ),
    );
  }
}