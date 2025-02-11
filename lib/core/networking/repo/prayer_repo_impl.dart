import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quran_app/core/networking/repo/dio_service.dart';
import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'package:quran_app/features/Home/data/model/sura.dart';
import 'package:quran_app/features/Quran_recitation/data/models/recitation.dart';
import 'package:quran_app/features/books/data/Book.dart';
import 'prayer_repo.dart'; // Import the abstract class

class PrayerRepositoryImpl implements PrayerRepository {
  final Dio _aladhanDio = DioService.aladhanDio;
  final Dio _islamHouseDio = DioService.islamHouseDio;

  @override
  Future<Timings?> fetchPrayerTimings({
    required String date,
    required String country,
    required String city,
  }) async {
    try {
      final response = await _aladhanDio.get(
        '/timingsByCity',
        queryParameters: {
          'date': date,
          'country': country,
          'city': city,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['timings'] != null) {
          return Timings.fromJson(data['timings']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchPrayerTimings: $e');
      return null;
    }
  }

  @override
  Future<Surah?> fetchSpecificSurah({required int surahNumber}) async {
    try {
      final response = await DioService.alquranDio.get('/surah/$surahNumber/ar.asad');

      if (response.statusCode == 200 && response.data != null) {
        return Surah.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchSpecificSurah: $e');
      return null;
    }
  }

  @override
  Future<List<Surah>?> fetchAllSurahs() async {
    try {
      final response = await DioService.alquranDio.get('/surah');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;

        return data.map((surah) {
          if (surah['number'] is String) {
            surah['number'] = int.tryParse(surah['number']) ?? 0;
          }
          return Surah.fromJson(surah);
        }).toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchAllSurahs: $e');
      return null;
    }
  }

  @override
  Future<MetaModel?> fetchPrayerMeta({
    required String date,
    required String country,
    required String city,
  }) async {
    try {
      final response = await _aladhanDio.get(
        '/timingsByCity',
        queryParameters: {
          'date': date,
          'country': country,
          'city': city,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['meta'] != null) {
          return MetaModel.fromJson(data['meta']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchPrayerMeta: $e');
      return null;
    }
  }

  @override
  Future<GregorianModel?> fetchMeladeDate({
    required String date,
    required String country,
    required String city,
  }) async {
    try {
      final response = await _aladhanDio.get(
        '/timingsByCity',
        queryParameters: {
          'date': date,
          'country': country,
          'city': city,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['date'] != null) {
          return GregorianModel.fromJson(data['date']['gregorian']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchMeladeDate: $e');
      return null;
    }
  }

  @override
  Future<HijriDateModel?> fetchHijriDate({
    required String date,
    required String country,
    required String city,
  }) async {
    try {
      final response = await _aladhanDio.get(
        '/timingsByCity',
        queryParameters: {
          'date': date,
          'country': country,
          'city': city,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['date'] != null) {
          return HijriDateModel.fromJson(data['date']['hijri']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchHijriDate: $e');
      return null;
    }
  }

  @override
  Future<List<Book>?> fetchAllBooks({
    required int authorId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await _islamHouseDio.get(
        '/main/get-author-items/$authorId/showall/ar/ar/$page/$limit/json',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data['data'];
        return data.map((book) => Book.fromJson(book)).toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchAllBooks: $e');
      return null;
    }
  }

  @override
  Future<Book?> fetchSpecificBook({
    required int bookId,
  }) async {
    try {
      final response = await _islamHouseDio.get(
        '/main/get-item/$bookId/ar/json',
      );

      if (response.statusCode == 200 && response.data != null) {
        return Book.fromJson(response.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error in fetchSpecificBook: $e');
      return null;
    }
  }

  @override
  Future<List<Recitation>> fetchQuranRecitation() async {
    try {
      final response = await _islamHouseDio.get(
        '/quran/get-category/364764/ar/json',
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['recitations'] as List;
        return data.map((e) => Recitation.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in fetchQuranRecitation: $e');
      return [];
    }
  }
}