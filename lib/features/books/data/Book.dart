import 'package:quran_app/features/books/data/Attachment.dart';
import 'package:quran_app/features/books/data/Author.dart';

class Book {
  final int id;
  final int sourceId;
  final String title;
  final String type;
  final int addDate;
  final String description;
  final String? fullDescription;
  final String sourceLanguage;
  final String translatedLanguage;
  final String? image;
  final String apiUrl;
  final List<Author> preparedBy;
  final List<Attachment> attachments;

  Book({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.type,
    required this.addDate,
    required this.description,
    this.fullDescription,
    required this.sourceLanguage,
    required this.translatedLanguage,
    this.image,
    required this.apiUrl,
    required this.preparedBy,
    required this.attachments,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      sourceId: json['source_id'],
      title: json['title'],
      type: json['type'],
      addDate: json['add_date'],
      description: json['description'],
      fullDescription: json['full_description'],
      sourceLanguage: json['source_language'],
      translatedLanguage: json['translated_language'],
      image: json['image'],
      apiUrl: json['api_url'],
      preparedBy: (json['prepared_by'] as List)
          .map((item) => Author.fromJson(item))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((item) => Attachment.fromJson(item))
          .toList(),
    );
  }
}



