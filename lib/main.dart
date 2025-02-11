import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_cubit.dart';
import 'package:quran_app/features/Home/data/manager/surah_cubit/surah_cubit.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/display_pray_times.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_provider.dart';
import 'package:quran_app/features/Quran_recitation/data/manager/quran_recitation_cubit.dart';
import 'package:quran_app/features/Splash/Splash_screen.dart';
import 'package:quran_app/features/books/data/manager/BookCubit/book_cubit.dart';

// Import the TeacherProvider


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TeacherProvider()),
          Provider<PrayerRepository>(
            create: (_) => PrayerRepositoryImpl(), // Use the correct implementation
          ),
          BlocProvider(
            create: (context) => BookCubit(Provider.of<PrayerRepository>(context, listen: false)),
          ),
          BlocProvider<QuranRecitationCubit>(
            create: (context) => QuranRecitationCubit(Provider.of<PrayerRepository>(context, listen: false)),
          ),
          BlocProvider(
            create: (_) => PrayerCubit(),
            child: PrayerTimes(),
          ),
          BlocProvider<SurahCubit>(
            create: (context) => SurahCubit(Provider.of<PrayerRepository>(context, listen: false)),
          ),
        ],
        child: MyApp(),
      )

  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844), // Set design size, adjust as needed
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: SplashScreen(),
          ),
          debugShowCheckedModeBanner: false,

        );
      },
    );
  }
}