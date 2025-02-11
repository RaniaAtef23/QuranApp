import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/model/sura.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  final PrayerRepository _quranRepository;

  SurahCubit(this._quranRepository) : super(SurahInitial());

  /// Fetch all Surahs
  Future<void> getAllSurahs() async {
    emit(SurahLoading());
    try {
      // Call the repository's method to fetch the surahs
      final surahs = await _quranRepository.fetchAllSurahs();
      debugPrint('Fetched Surahs: $surahs'); // Log the result for debugging

      if (surahs != null && surahs.isNotEmpty) {
        emit(SurahLoaded(surahs)); // Emit the SurahLoaded state
      } else {
        emit(SurahError("No Surahs found")); // Handle case where no surahs are found
      }
    } catch (e) {
      debugPrint('Error in fetchAllSurahs: $e'); // Log error for debugging
      emit(SurahError("Error: $e")); // Emit error state if something goes wrong
    }
  }

  /// Fetch a specific Surah
  Future<void> getSurahByNumber(int surahNumber) async {
    emit(SurahLoading());
    try {
      final surah = await _quranRepository.fetchSpecificSurah(surahNumber: surahNumber);
      if (surah != null) {
        emit(SpecificSurahLoaded(surah));
      } else {
        emit(SurahError("Failed to load Surah"));
      }
    } catch (e) {
      emit(SurahError("Error: $e"));
    }
  }
}