import 'package:flutter/material.dart';

class TeacherProvider extends ChangeNotifier {
  final Map<String, String> _teachers = {}; // Store teachers with their emails
  final Map<String, List<String>> _teacherStudents = {}; // Store students per teacher

  Map<String, String> get teachers => _teachers;
  Map<String, List<String>> get teacherStudents => _teacherStudents;

  void addTeacher(String teacher, String email) {
    _teachers[teacher] = email; // Store teacher name with email
    _teacherStudents.putIfAbsent(teacher, () => []); // Initialize student list if not exists
    notifyListeners();
  }

  void subscribeStudent(String teacher, String student) {
    if (_teacherStudents.containsKey(teacher)) {
      if (!_teacherStudents[teacher]!.contains(student)) {
        _teacherStudents[teacher]!.add(student);
        notifyListeners();
      }
    }
  }

  List<String> getStudents(String teacher) {
    return _teacherStudents[teacher] ?? [];
  }
}
