
import 'package:quran_app/features/Quran_recitation/data/models/recitation.dart';


abstract class QuranRecitationState  {
  const QuranRecitationState();

  @override
  List<Object?> get props => [];
}

class QuranRecitationInitial extends QuranRecitationState {}

class QuranRecitationLoading extends QuranRecitationState {}

class QuranRecitationLoaded extends QuranRecitationState {
  final List<Recitation> recitations;

  QuranRecitationLoaded(this.recitations);

  @override
  List<Object?> get props => [recitations];
}

class QuranRecitationError extends QuranRecitationState {
  final String message;

  QuranRecitationError(this.message);

  @override
  List<Object?> get props => [message];
}
