import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/validator.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/core/widgets/back_button.dart';
import 'package:quran_app/core/widgets/custom_button.dart';
import 'package:quran_app/core/widgets/custom_text_field.dart';
import 'package:quran_app/features/authentication/presentation/verify_screen.dart';


class ForgetPassWidget extends StatefulWidget {
  final Function? onSubmit;

  const ForgetPassWidget({
    super.key,
    this.onSubmit,
  });

  @override
  ForgetPassWidgetState createState() => ForgetPassWidgetState();
}

class ForgetPassWidgetState extends State<ForgetPassWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Call the onSubmit function if it's provided
      if (widget.onSubmit != null) {
        widget.onSubmit!();
      }
      // Navigate to VerifyScreen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VerifyScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button at the top with red border, centered inside the container
              BackButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50.h),
              Text("نسيت كلمة المرور؟", style: TextStyles.font24darkBrownMedium),
              SizedBox(height: 20.h),
              Text("أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور الخاصة بك، وسنرسل لك رمز التأكيد", style: TextStyles.font16lightGreyRegular),
              SizedBox(height: 20.h),
              Container(
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
                      Text("البريد الالكتروني", style: TextStyles.font16blackMedium),
                      SizedBox(height: 5.h),
                      Center(
                        child: CustomTextField(
                          hintText: 'ادخل بريدك الالكتروني',
                          controller: _emailController,
                          validator: Validator.emailValidator,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Center(
                        child: CustomButton(
                          text: 'ارسال',
                          onPressed: _submit, // Call _submit on press
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
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
