import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_cubit.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_state.dart';
import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'package:quran_app/features/Home/presentation/widgets/home_widget/Home_body.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/Data_info.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/Feature_icon.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/circular_slider.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/time_zone_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrayerCubit()..fetchPrayerData(),
      child: Scaffold(
        body: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            if (state is PrayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PrayerError) {
              return Center(child: Text(state.message));
            } else if (state is PrayerLoaded) {
              // Access the loaded data
              HijriDateModel hijriDate = state.hijriDate;
              GregorianModel meladeDate = state.meladeDate;
              MetaModel metaData = state.metaData;

              // Fetch user data from SharedPreferences
              return FutureBuilder(
                future: _loadUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading user data: ${snapshot.error}'));
                  } else {
                    final userData = snapshot.data as Map<String, String?>;
                    final userName = userData['userName'] ?? 'Guest';
                    final userType = userData['userType'] ?? 'User';
                    final userEmail=userData['userEmail']??'Eamil';
                    print('Debug: Email3 = ${userEmail}');
                    return HomePageContent(
                      hijriDate: hijriDate,
                      meladeDate: meladeDate,
                      metaData: metaData,
                      userName: userName,
                      userType: userType, email: userEmail,


                    );
                  }
                },
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }

  // Helper method to load user data from SharedPreferences
  Future<Map<String, String?>> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userName': prefs.getString('userName'),
      'userType': prefs.getString('userType'),
      'userEmail':prefs.getString('userEmail')
    };
  }
}