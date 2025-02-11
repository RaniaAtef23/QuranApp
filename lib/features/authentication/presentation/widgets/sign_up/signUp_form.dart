import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/core/helpers/validator.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/core/widgets/custom_button.dart';
import 'package:quran_app/core/widgets/custom_text_field.dart';

// Service to handle SharedPreferences operations
class SharedPrefsService {
  static const String _registeredEmailsKey = 'registeredEmails';

  // Save a list of registered emails
  static Future<void> saveRegisteredEmails(List<String> emails) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_registeredEmailsKey, emails);
  }

  // Retrieve the list of registered emails
  static Future<List<String>> getRegisteredEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_registeredEmailsKey) ?? [];
  }
}

class SignupForm extends StatefulWidget {
  final Function? onSignup;
  final bool agreeToTerms;
  final Function(bool?) onAgreeToTermsChanged;

  const SignupForm({
    super.key,
    this.onSignup,
    required this.agreeToTerms,
    required this.onAgreeToTermsChanged,
  });

  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  List<String> _registeredEmails = [];

  @override
  void initState() {
    super.initState();
    _loadRegisteredEmails();
  }

  Future<void> _loadRegisteredEmails() async {
    _registeredEmails = await SharedPrefsService.getRegisteredEmails();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();

      // Check if the email already exists
      if (_registeredEmails.contains(email)) {
        // Show an alert and prevent account creation
        _showEmailExistsDialog();
      } else {
        // Add the new email to the registered emails list
        _registeredEmails.add(email);

        // Save the updated list to SharedPreferences
        await SharedPrefsService.saveRegisteredEmails(_registeredEmails);

        // Proceed with account creation (call the callback if provided)
        if (widget.onSignup != null) {
          widget.onSignup!();
        }

        // Show success dialog after account creation
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
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
                Image.network(
                  'assets/login/sign_up.png', // Replace with your image path
                  width: 100.w,
                  height: 100.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "تم إنشاء الحساب بنجاح",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: TextColors.darkBrown,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "لقد تم إنشاء حسابك بنجاح، يمكنك الآن تسجيل الدخول.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'موافق',
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

  void _showEmailExistsDialog() {
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
                  "البريد الإلكتروني موجود مسبقاً",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "البريد الإلكتروني الذي أدخلته موجود مسبقاً. الرجاء استخدام بريد إلكتروني آخر.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),
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
              child: Text("البريد الالكتروني", style: TextStyles.font16blackMedium),
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
              child: Text("كلمة المرور", style: TextStyles.font16blackMedium),
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
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text("تأكيد كلمة المرور", style: TextStyles.font16blackMedium),
            ),
            SizedBox(height: 5.h),
            Center(
              child: CustomTextField(
                hintText: 'ادخل كلمة المرور',
                isPassword: true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 327.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Transform.scale(
                      scale: 1.4,
                      child: Checkbox(
                        splashRadius: 4,
                        value: widget.agreeToTerms,
                        onChanged: widget.onAgreeToTermsChanged,
                        activeColor: TextColors.darkBrown,
                        side: const BorderSide(
                          color: TextColors.lightGrey,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 18.h),
                      child: Wrap(
                        children: [
                          Text("أوافق على ", style: TextStyles.font14grey600regular),
                          Text(
                            "شروط خدمة ",
                            style: TextStyle(
                              color: TextColors.darkBrown,
                              fontWeight: FontWeight.bold,
                              fontFamily: "NotoSans",
                              fontSize: 14.sp,
                            ),
                          ),
                          Text("المنصة و", style: TextStyles.font14grey600regular),
                          Text(
                            "سياسة ",
                            style: TextStyle(
                              color: TextColors.darkBrown,
                              fontWeight: FontWeight.bold,
                              fontFamily: "NotoSans",
                              fontSize: 14.sp,
                            ),
                          ),
                          const Text(
                            "الخصوصية",
                            style: TextStyle(
                              color: TextColors.darkBrown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: CustomButton(
                text: 'إنشاء حساب',
                onPressed: _signup,
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Text(
                "خيارات تسجيل الدخول الأخرى",
                style: TextStyles.font14blackRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}