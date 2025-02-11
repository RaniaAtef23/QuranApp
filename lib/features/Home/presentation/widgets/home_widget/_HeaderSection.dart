import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/Data_info.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/circular_slider.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/time_zone_info.dart';
class HeaderSection extends StatelessWidget {
  final HijriDateModel hijriDate;
  final GregorianModel meladeDate;
  final MetaModel metaData;
  final String userName;
  final String userType;
  final String email;
  final Uint8List? profileImage;
  final VoidCallback onProfileTap;

  const HeaderSection({
    required this.hijriDate,
    required this.meladeDate,
    required this.metaData,
    required this.userName,
    required this.userType,
    required this.email,
    this.profileImage,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Home/Frame 3.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h, left: 10.w),
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImage != null
                        ? MemoryImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? Icon(Icons.person, size: 20.w, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, $userName!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Role: $userType',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 20.w),
                  child: Image.asset('assets/Home/Vector.png'),
                ),
              ],
            ),
            SizedBox(height: 90.h),
            SizedBox(
              width: 342.w,
              height: 90.h,
              child: Row(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Column(
                        children: [
                          DateInfo(
                            weekday: hijriDate.weekday.ar,
                            meladeDate: " ${meladeDate.month.en}${meladeDate.day}",
                            hijriDate: "${hijriDate.day} ${hijriDate.month.ar}",
                          ),
                          TimezoneInfo(timezone: metaData.timezone),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  const Expanded(child: CircularSlider()),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(metaData.timezone, style: TextStyles.font16white500),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}