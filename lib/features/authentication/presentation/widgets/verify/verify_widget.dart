import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/core/widgets/back_button.dart';
import 'package:quran_app/core/widgets/custom_button.dart';
import 'package:quran_app/features/Type/presentation/UserTypePage.dart';
import 'package:quran_app/features/authentication/presentation/auth_screen.dart';
import 'package:quran_app/features/authentication/presentation/widgets/verify/OTP_field.dart';
import 'package:quran_app/features/authentication/presentation/widgets/verify/request.dart';

class VerifyWidget extends StatefulWidget {
  const VerifyWidget({super.key});

  @override
  State<VerifyWidget> createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<VerifyWidget> {
  final List<String> otpValues = List.filled(6, ''); // Initialize with empty strings

  @override
  Widget build(BuildContext context) {
    final focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonWidget(onTap: () => Navigator.pop(context)),
              SizedBox(height: 50.h),
              Text("رمز التحقق", style: TextStyles.font24darkBrownMedium),
              SizedBox(height: 20.h),
              Text(
                "أدخل الرمز الذي أرسلناه إلى رقمك 012345*****",
                style: TextStyles.font16lightGreyRegular,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 6; i++)
                    OtpDigitField(
                      currentFocus: focusNodes[i],
                      nextFocus: i < 5 ? focusNodes[i + 1] : null,
                      fieldWidth: 40.sp,

                    ),
                ],
              ),
              SizedBox(height: 40.h),
              Center(
                child: CustomButton(
                  text: 'تحقق',
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Allows closing the dialog by tapping outside
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            height: 401.h, // Set the height of the dialog
                            padding: EdgeInsets.all(16.w), // Add padding around the content
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 30.h,),
                                Image.network('assets/verify/Done.png'),
                                SizedBox(height: 30.h), // Space between title and content
                                Center( // Center the title
                                  child: Text(
                                    'تم بنجاح',
                                    style: TextStyles.font24black2Bold,
                                  ),
                                ),
                                SizedBox(height: 20.h), // Space between title and content
                                Center( // Center the content
                                  child: Text(
                                    'لقد تم إعادة تعيين كلمة المرور الخاصة بك بنجاح.',
                                    style: TextStyles.font16grey400,
                                    textAlign: TextAlign.center, // Center the content text
                                  ),
                                ),
                                SizedBox(height: 20.h), // Space between title and content
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen()));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(//Color(0xCCA85000)
                                          colors: [Color(0xCCA85000),Color(0xCC522700)], // Gradient colors
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(33.r),
                                        ),
                                      ),
                                    width: 183.w,
                                    height: 52.h,
                                    child: Center(child: Text("تسجيل الدخول",style: TextStyles.font18whitesemiBold,))
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),


              SizedBox(height: 25.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لم تستلم الرمز؟",
                      style: TextStyles.font16lightGreyRegular,
                    ),
                    Text(
                      "إعادة ارسال",
                      style: TextStyles.font18darkbrownRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
