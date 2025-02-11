import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/features/books/data/manager/BookCubit/book_cubit.dart';
import 'package:quran_app/features/books/data/manager/BookCubit/book_state.dart';
import 'package:quran_app/features/books/presentation/widgets/BookItem.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  String _searchQuery = ''; // State to manage the search query

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bookCubit = BookCubit(context.read<PrayerRepository>());
        bookCubit.fetchAllBooks(8624); // Example category ID
        return bookCubit;
      },
      child: Scaffold(
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if (state is BookLoadingAllBooks) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown, // Changed from green to brown
                ),
              );
            } else if (state is AllBooksLoaded) {
              final books = state.books;
              if (books.isEmpty) {
                return _emptyStateWidget();
              }

              // Filter books based on the search query
              final filteredBooks = books
                  .where((book) => book.title
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
                  .toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Search Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Back Button
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back_ios, color: Colors.brown), // Changed from green to brown
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '📚 موسوعة من الكتب الاسلامية',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[800],
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Search Bar
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown[700],
                            ),
                            decoration: InputDecoration(
                              hintText: '🔍 ابحث عن كتاب...',
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: TextStyle(color: Colors.brown[400]),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filtered Book List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: BookItem(book: filteredBooks[index]),
                        );
                      },
                    ),

                    // Show "No Results" if no books match the search query
                    if (filteredBooks.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            '⚠️ لا توجد نتائج مطابقة لبحثك.',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            } else if (state is BookError) {
              return const Center(
                child: Text(
                  '⚠️ حدث خطأ أثناء تحميل الكتب. حاول مرة أخرى.',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return _emptyStateWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _emptyStateWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/empty_books.png', // Replace with your empty state image
          height: 150,
        ),
        const SizedBox(height: 20),
        Text(
          'لا توجد كتب متاحة حاليًا',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
