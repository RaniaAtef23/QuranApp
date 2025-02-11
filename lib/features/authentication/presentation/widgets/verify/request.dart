import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/presentation/main_screen.dart';

class Request extends StatelessWidget {
  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    // Delay the navigation to the home screen by 5 seconds
    Future.delayed(const Duration(seconds: 9), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()), // Replace with your home screen widget
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 115.h),
            Center(child: Image.asset('assets/login/Frame 43.png')), // Use Image.asset instead of Image.network
            SizedBox(height: 30.h),
            Text("تم ارسال طلبك", style: TextStyles.font24darkbrownsemiBold),
            SizedBox(height: 20.h),
            Text("يرجى الانتظار..", style: TextStyles.font16blackMedium),
            Text("سيقوم المسؤولون بتسكينك مع أحد المحفظين", style: TextStyles.font16blackMedium)
          ],
        ),
      ),
    );
  }
}