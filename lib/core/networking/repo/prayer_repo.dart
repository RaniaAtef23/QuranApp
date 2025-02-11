import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'package:quran_app/features/Home/data/model/sura.dart';
import 'package:quran_app/features/Quran_recitation/data/models/recitation.dart';
import 'package:quran_app/features/books/data/Book.dart';

abstract class PrayerRepository {
  /// Fetch Prayer Timings
  Future<Timings?> fetchPrayerTimings({
    required String date,
    required String country,
    required String city,
  });

  /// Fetch a specific Surah by its number
  Future<Surah?> fetchSpecificSurah({required int surahNumber});

  /// Fetch all Surahs
  Future<List<Surah>?> fetchAllSurahs();

  /// Fetch Meta Information
  Future<MetaModel?> fetchPrayerMeta({
    required String date,
    required String country,
    required String city,
  });

  /// Fetch Gregorian Date (Melade Date)
  Future<GregorianModel?> fetchMeladeDate({
    required String date,
    required String country,
    required String city,
  });

  /// Fetch Hijri Date
  Future<HijriDateModel?> fetchHijriDate({
    required String date,
    required String country,
    required String city,
  });

  /// Fetch Books from Islam House
  Future<List<Book>?> fetchAllBooks({
    required int authorId,
    int page = 1,
    int limit = 50,
  });

  /// Fetch Specific Book by ID from Islam House
  Future<Book?> fetchSpecificBook({
    required int bookId,
  });

  /// Fetch Quran Recitation
  Future<List<Recitation>> fetchQuranRecitation();
}