import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TasbeehStorage {
  Future<void> saveTasbeeh(String tasbeeh, int count) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tasbeehList = prefs.getStringList('tasbeeh_records') ?? [];

    tasbeehList.add(jsonEncode({'tasbeeh': tasbeeh, 'count': count}));
    await prefs.setStringList('tasbeeh_records', tasbeehList);
  }

  Future<List<Map<String, dynamic>>> getTasbeehRecords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tasbeehList = prefs.getStringList('tasbeeh_records') ?? [];

    return tasbeehList.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }
}
