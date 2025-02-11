import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _registeredEmailsKey = 'registeredEmails';

  // Save a list of registered emails
  static Future<void> saveRegisteredEmails(List<String> emails) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_registeredEmailsKey, emails);
  }

  // Retrieve the list of registered emails
  static Future<List<String>> getRegisteredEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_registeredEmailsKey) ?? [];
  }
}