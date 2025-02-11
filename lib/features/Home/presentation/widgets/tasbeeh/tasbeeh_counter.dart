import 'package:flutter/material.dart';

class TasbeehCounter {
  static final TasbeehCounter _instance = TasbeehCounter._internal();

  final Map<String, int> _counters = {
    "سبحان الله": 0,
    "الحمد لله": 0,
    "الله أكبر": 0,
    "لا إله إلا الله": 0,
    "أستغفر الله": 0,
  };

  factory TasbeehCounter() {
    return _instance;
  }

  TasbeehCounter._internal();

  int getCounter(String tasbeeh) {
    return _counters[tasbeeh] ?? 0;
  }

  void setCounter(String tasbeeh, int value) {
    _counters[tasbeeh] = value;  // Set the counter to a specific value
  }

  void incrementCounter(String tasbeeh) {
    _counters[tasbeeh] = (_counters[tasbeeh] ?? 0) + 1;
  }

  void resetCounter(String tasbeeh) {
    _counters[tasbeeh] = 0;
  }

  Map<String, int> getCounters() {
    return _counters;
  }
}
