import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/authentication/presentation/Login_screen.dart';
import 'package:quran_app/features/authentication/presentation/SignUp_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    const LinearGradient(
                      colors: [Color(0xFFA85000), Color(0xFF522700)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Padding(
                  padding: EdgeInsets.only(top: 80.h),
                  child: Text(
                    "مسلم",
                    style: TextStyles.font32WhiteBold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 290.w,
                child: Center(
                  child: Text(
                    "قم بتسجيل الدخول أو إنشاء حساب جديد لحفظ تقدمك",
                    style: TextStyles.font16lightGreyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20.h), // Space above TabBar
              Padding(
                padding:  EdgeInsets.symmetric( horizontal: 24.w),
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0x0a000000), // Color of unselected tabs
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: -10,vertical: 5),
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    labelColor: TextColors.darkBrown,
                    labelStyle: TextStyles.font16semiBold,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyles.font16regular,
                    indicator: BoxDecoration(
                      color:Colors.white, // Color of selected tab
                      borderRadius: BorderRadius.circular(12), // Rounded corners for the indicator
                    ),
                    tabs: [
                      SizedBox(
                          height:50.h,
                          width: double.infinity,
                          child: const Tab(text: "إنشاء حساب")),
                      SizedBox(
                          height:50.h,
                          width: double.infinity,
                          child: const Tab(text: "تسجيل الدخول")),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SignupScreen(),
                    LoginScreen(),


                  ],
                ),
              ),

            ],
          ),
        ),

    );
  }


}
