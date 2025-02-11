import 'package:flutter/material.dart';
import 'package:quran_app/features/Home/presentation/widgets/azkar/azkar_page.dart';
import 'package:quran_app/features/Home/presentation/widgets/calender/calender_screen.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/display_pray_times.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/Feature_icon.dart';
import 'package:quran_app/features/Home/presentation/widgets/surah/surah_screen.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/Tasbeh_page.dart';
class FeatureIconsRow extends StatelessWidget {
  const FeatureIconsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarView()));
          },
          child: const FeatureIcon(
            assetPath: "assets/Home/clarity_date-line.png",
            label: "التقويم",
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerTimes()));
          },
          child: const FeatureIcon(
            assetPath: "assets/Home/guidance_praying-room.png",
            label: "الصلاة",
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SurahListScreen()));
          },
          child: const FeatureIcon(
            assetPath: "assets/Home/ion_book-outline.png",
            label: "قران",
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AzkarPage()));
          },
          child: const FeatureIcon(
            assetPath: "assets/Home/azkar.png",
            label: "الاذكار",
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TasbeehPage()));
          },
          child: const FeatureIcon(
            assetPath: "assets/Home/tasbeeh.png",
            label: "التسبيح",
          ),
        ),
      ],
    );
  }
}