// prayer_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerRepository _repo = PrayerRepositoryImpl();

  PrayerCubit() : super(PrayerInitial());

  Future<void> fetchPrayerData() async {
    emit(PrayerLoading());

    try {
      final hijriDate = await _repo.fetchHijriDate(
        date: '15-02-2024',
        country: 'Egypt',
        city: 'Cairo',
      );
      final meladeDate = await _repo.fetchMeladeDate(
        date: '15-02-2024',
        country: 'Egypt',
        city: 'Cairo',
      );
      final metaData = await _repo.fetchPrayerMeta(
        date: '15-02-2024',
        country: 'Egypt',
        city: 'Cairo',
      );

      if (hijriDate != null && meladeDate != null && metaData != null) {
        emit(PrayerLoaded(
          hijriDate: hijriDate,
          meladeDate: meladeDate,
          metaData: metaData,
        ));
      } else {
        emit(PrayerError('Failed to fetch data.'));
      }
    } catch (e) {
      emit(PrayerError('Error fetching data: $e'));
    }
  }
}
