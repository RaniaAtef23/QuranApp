part of 'surah_cubit.dart';

@immutable
abstract class SurahState {}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<Surah> surahs;
  SurahLoaded(this.surahs);
}

class SpecificSurahLoaded extends SurahState {
  final Surah surah;
  SpecificSurahLoaded(this.surah);
}

class SurahError extends SurahState {
  final String message;
  SurahError(this.message);
}
