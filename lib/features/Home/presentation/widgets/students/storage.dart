import 'package:shared_preferences/shared_preferences.dart';

class StudentStorage {
  Future<void> addStudentToTeacher(String teacherUsername, String studentUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> students = await getStudents(teacherUsername);
    if (!students.contains(studentUsername)) {
      students.add(studentUsername);
      await prefs.setStringList('students_$teacherUsername', students);
    }
  }

  Future<List<String>> getStudents(String teacherUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('students_$teacherUsername') ?? [];
  }
}