import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/ActionButtonWidget.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/CounterDisplayWidget.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/TasbeehSelectorWidget.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/tasbeeh_counter.dart';

class TasbeehPage extends StatefulWidget {
  @override
  _TasbeehPageState createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  final List<String> tasbeehOptions = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
    "أستغفر الله",
  ];

  String selectedTasbeeh = "سبحان الله";
  final TasbeehCounter _tasbeehCounter = TasbeehCounter();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  // Load the counter from SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    for (String tasbeeh in tasbeehOptions) {
      int savedCount = prefs.getInt(tasbeeh) ?? 0;
      _tasbeehCounter.setCounter(tasbeeh, savedCount);
    }
    setState(() {});
  }

  // Save the counter to SharedPreferences
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedTasbeeh, _tasbeehCounter.getCounter(selectedTasbeeh));
  }

  void incrementCounter() {
    HapticFeedback.lightImpact();
    setState(() {
      _tasbeehCounter.incrementCounter(selectedTasbeeh);
    });
    _saveCounter(); // Save after increment
  }

  void resetCounter() async {
    HapticFeedback.mediumImpact();
    _tasbeehCounter.resetCounter(selectedTasbeeh);
    await _saveCounter(); // Save after reset
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffa85000),
          title: const Text(
            "عداد التسبيح",
            style: TextStyle(fontFamily: 'Amiri', fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Background with Gradient Overlay
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Home/craiyon_004642_islamic_art_white_altar_window.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Main Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tasbeeh Selector
                    TasbeehSelectorWidget(
                      selectedTasbeeh: selectedTasbeeh,
                      tasbeehOptions: tasbeehOptions,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTasbeeh = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 40),

                    // Counter Display
                    CounterDisplayWidget(counter: _tasbeehCounter.getCounter(selectedTasbeeh)),
                    const SizedBox(height: 40),

                    // Action Buttons
                    ActionButtonsWidget(
                      onIncrement: incrementCounter,
                      onReset: resetCounter,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
