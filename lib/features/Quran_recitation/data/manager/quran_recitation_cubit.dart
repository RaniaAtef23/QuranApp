import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/features/Quran_recitation/data/manager/quran_recitation_state.dart';

class QuranRecitationCubit extends Cubit<QuranRecitationState> {
  final PrayerRepository prayerRepository;

  QuranRecitationCubit(this.prayerRepository) : super(QuranRecitationInitial());

  Future<void> fetchQuranRecitation() async {
    try {
      emit(QuranRecitationLoading());
      final recitations = await prayerRepository.fetchQuranRecitation();

      if (recitations.isNotEmpty) {
        emit(QuranRecitationLoaded(recitations));
      } else {
        emit(QuranRecitationError('No recitations found.'));
      }
    } catch (e) {
      emit(QuranRecitationError('Failed to fetch recitations: $e'));
    }
  }
}

