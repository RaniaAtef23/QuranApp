import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/manager/surah_cubit/surah_cubit.dart';
import 'package:quran_app/features/Home/data/model/sura.dart';
import 'package:quran_app/features/Home/presentation/widgets/surah/surah_list_view.dart';
import 'package:quran_app/features/Home/presentation/widgets/surah/surah_screen.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سور القران الكريم')),
      body: BlocProvider(
        create: (context) => SurahCubit(PrayerRepositoryImpl()),
        child: SurahListView(),
      ),
    );
  }
}



