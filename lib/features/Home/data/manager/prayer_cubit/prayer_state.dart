// prayer_state.dart

import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final HijriDateModel hijriDate;
  final GregorianModel meladeDate;
  final MetaModel metaData;

  PrayerLoaded({
    required this.hijriDate,
    required this.meladeDate,
    required this.metaData,
  });
}

class PrayerError extends PrayerState {
  final String message;
  PrayerError(this.message);
}
