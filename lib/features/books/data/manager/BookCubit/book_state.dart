import 'package:quran_app/features/books/data/Book.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoadingAllBooks extends BookState {}

class BookLoadingSpecificBook extends BookState {}

class AllBooksLoaded extends BookState {
  final List<Book> books;

  AllBooksLoaded(this.books);
}

class SpecificBookLoaded extends BookState {
  final Book book;

  SpecificBookLoaded(this.book);
}

class BookError extends BookState {
  final String message;

  BookError(this.message);
}
