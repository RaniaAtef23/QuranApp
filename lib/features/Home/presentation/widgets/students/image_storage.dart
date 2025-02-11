import 'dart:typed_data';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/tasbeeh_counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageStorage {
  final TasbeehCounter _tasbeehCounter = TasbeehCounter();
  /// Saves an image as a Uint8List in SharedPreferences
  Future<void> setImageData(String key, Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    final imageString = String.fromCharCodes(imageBytes);
    await prefs.setString(key, imageString);
  }

  /// Retrieves an image as a Uint8List from SharedPreferences
  Future<Uint8List?> getImageData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final imageString = prefs.getString(key);

    if (imageString == null) return null;

    return Uint8List.fromList(imageString.codeUnits);
  }
  Map<String, int> get counters => _tasbeehCounter.getCounters();
}
