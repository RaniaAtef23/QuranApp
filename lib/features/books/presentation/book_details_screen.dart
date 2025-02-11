import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/books/data/Book.dart';
import 'package:quran_app/features/books/presentation/widgets/web_view_page.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookUrl;
  final Book book;

  const BookDetailScreen({super.key, required this.bookUrl, required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String preparedByText = widget.book.preparedBy.isNotEmpty
        ? widget.book.preparedBy.map((author) => author.title).join(', ')
        : 'No authors available';

    String attachmentText = widget.book.attachments.isNotEmpty
        ? widget.book.attachments.map((attachment) => attachment.size).join(', ')
        : 'No attachments available';

    // Use the first attachment's URL if available
    String bookLink = widget.book.attachments.isNotEmpty
        ? widget.book.attachments.first.url // Assuming first attachment's URL
        : '';

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.book.title ?? 'No Title',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.network(
                  "assets/books/book (2).png",
                  width: 200,
                  height: 400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.brown.shade700, Colors.yellow.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          widget.book.title ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        preparedByText,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.book.description ?? 'No description available',
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "الحجم: $attachmentText",
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (bookLink.isNotEmpty) {
                            print(bookLink);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewPage(url: bookLink),
                              ),
                            );
                          } else {
                            // Show a message if there's no valid URL
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No valid book link available')),
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.brown.shade600, Colors.yellow.shade900],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          child: const Text(
                            'تصفح الكتاب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
