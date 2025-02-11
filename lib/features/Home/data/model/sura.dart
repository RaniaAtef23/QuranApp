import 'package:quran_app/features/Home/data/model/Aya.dart';

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  final List<Ayah> ayahs; // Add list of Ayah

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.ayahs, // Initialize list in constructor
  });

  // Factory method to convert JSON to Surah object
  factory Surah.fromJson(Map<String, dynamic> json) {
    var ayahsJson = json['ayahs'] as List? ?? [];
    List<Ayah> ayahsList = ayahsJson.map((ayahJson) => Ayah.fromJson(ayahJson)).toList();

    return Surah(
      number: _parseNumber(json['number']),
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      revelationType: json['revelationType'] ?? '',
      ayahs: ayahsList, // Set list of Ayahs
    );
  }

  // Helper function to safely parse the number (handling string or null cases)
  static int _parseNumber(dynamic number) {
    if (number is String) {
      return int.tryParse(number) ?? 0; // If it's a string, try parsing to int
    } else if (number is int) {
      return number;
    }
    return 0; // Return 0 if it's null or any other unexpected type
  }



  // Override toString() for better debugging output
  @override
  String toString() {
    return 'Surah(number: $number, name: $name, englishName: $englishName, '
        'englishNameTranslation: $englishNameTranslation, numberOfAyahs: $numberOfAyahs, '
        'revelationType: $revelationType, ayahs: $ayahs)';
  }
}
