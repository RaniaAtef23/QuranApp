import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/features/books/data/manager/BookCubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final PrayerRepository _prayerRepository;

  BookCubit(this._prayerRepository) : super(BookInitial());

  /// Fetch all books for a specific author
  Future<void> fetchAllBooks(int authorId) async {
    emit(BookLoadingAllBooks());
    try {
      final books = await _prayerRepository.fetchAllBooks(authorId: authorId);
      print('Fetched books: $books');  // Debugging step

      if (books != null && books.isNotEmpty) {
        emit(AllBooksLoaded(books));
      } else {
        emit(BookError("No books found"));
      }
    } catch (e) {
      emit(BookError(e.toString()));
    }

  }

  /// Fetch a specific book by its ID
  Future<void> fetchSpecificBook(int bookId) async {
    emit(BookLoadingSpecificBook());
    try {
      final book = await _prayerRepository.fetchSpecificBook(bookId: bookId);
      if (book != null) {
        emit(SpecificBookLoaded(book)); // State for loading a specific book
      } else {
        emit(BookError("Failed to load book details"));
      }
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
