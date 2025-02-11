import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'package:quran_app/features/Home/presentation/widgets/azkar/azkar_datails.dart';
import 'package:quran_app/features/Home/presentation/widgets/calender/calender_widget.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime today = DateTime.now();
  late Timer _timer;
  int daysUntilRamadan = 0;
  Map<String, TimeOfDay> _prayerTimes = {};
  String nextPrayer = "جاري التحديث...";
  String azkarType = "";
  String type = "sleep";
  final PrayerRepository _repo = PrayerRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _calculateDaysUntilRamadan();
    _startRamadanCountdown();
    _fetchPrayerTimes();
  }

  void _calculateDaysUntilRamadan() {
    // Get the current Hijri date
    HijriCalendar hijriToday = HijriCalendar.now();

    // Calculate the start of Ramadan for the current Hijri year
    HijriCalendar ramadanStart = HijriCalendar()
      ..hYear = hijriToday.hYear
      ..hMonth = 9 // Ramadan is the 9th month
      ..hDay = 1; // Ramadan starts on the 1st day of the 9th month

    // If Ramadan has already passed this year, calculate for next year
    if (hijriToday.isAfter(ramadanStart.hYear, ramadanStart.hMonth, ramadanStart.hDay)) {
      ramadanStart.hYear += 1;
    }

    // Convert the Hijri Ramadan start date to Gregorian
    DateTime ramadanGregorian = ramadanStart.hijriToGregorian(ramadanStart.hYear, ramadanStart.hMonth, ramadanStart.hDay);

    // Calculate the difference in days
    setState(() {
      daysUntilRamadan = ramadanGregorian.difference(today).inDays;
    });
  }

  void _startRamadanCountdown() {
    _timer = Timer.periodic(const Duration(days: 1), (timer) {
      _calculateDaysUntilRamadan();
    });
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      final prayerTimings = await _repo.fetchPrayerTimings(
        date: DateFormat('dd-MM-yyyy').format(today),
        country: 'Egypt',
        city: 'Cairo',
      );

      if (prayerTimings != null) {
        setState(() {
          _initializePrayerTimes(prayerTimings);
          nextPrayer = _getNextPrayer();
          _determineAzkarType();
        });
      }
    } catch (e) {
      debugPrint('Error fetching prayer times: $e');
    }
  }


  void _initializePrayerTimes(Timings timings) {
    _prayerTimes = {
      "الفجر": _parseTime(timings.fajr),
      "الظهر": _parseTime(timings.dhuhr),
      "العصر": _parseTime(timings.asr),
      "المغرب": _parseTime(timings.maghrib),
      "العشاء": _parseTime(timings.isha),
    };
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _getNextPrayer() {
    final now = TimeOfDay.fromDateTime(DateTime.now());
    for (var entry in _prayerTimes.entries) {
      final prayerTime = entry.value;
      if (prayerTime.hour > now.hour ||
          (prayerTime.hour == now.hour && prayerTime.minute > now.minute)) {
        return entry.key;
      }
    }
    return "الفجر";
  }

  void _determineAzkarType() {
    final now = TimeOfDay.fromDateTime(DateTime.now());

    if (_prayerTimes["الفجر"] != null &&
        _isTimeAfter(now, _prayerTimes["الفجر"]!) &&
        !_isTimeAfter(now, _prayerTimes["الظهر"]!)) {
      azkarType = "اذكار الصباح";
      type = 'morning';
    } else if (_prayerTimes["العصر"] != null &&
        _isTimeAfter(now, _prayerTimes["العصر"]!) &&
        !_isTimeAfter(now, _prayerTimes["المغرب"]!)) {
      azkarType = "اذكار المساء";
      type = "evening";
    } else if (_prayerTimes["العشاء"] != null &&
        _isTimeAfter(now, _prayerTimes["العشاء"]!)) {
      azkarType = "دعاء الليل ";
      type = "sleep";
    } else {
      azkarType = " دعاء الليل";
    }
    setState(() {});
  }

  bool _isTimeAfter(TimeOfDay now, TimeOfDay time) {
    return now.hour > time.hour || (now.hour == time.hour && now.minute > time.minute);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xffa85000),
        title: const Text(
          'التقويم الإسلامي',
          style: TextStyle(fontFamily: 'Amiri', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffa85000), Color(0xff8a5d3b)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.nightlight_round, color: Colors.white, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                      'كم تبقى لرمضان؟',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          ' يومًا حتى رمضان',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          ' $daysUntilRamadan',
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              const CalenderWidget(),
              SizedBox(height: 20.h),
              _buildCard(
                title: '✨ حديث اليوم ✨',
                content: const Text(
                  'قال رسول الله ﷺ: "خيركم من تعلم القرآن وعلمه"',
                  style: TextStyle(fontSize: 18, fontFamily: 'Amiri', color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                titleColor: Colors.brown,
              ),
              SizedBox(height: 20.h),
              _buildCard(
                title: '🕌 الصلاة القادمة',
                content: Text(
                  'الصلاة القادمة: $nextPrayer\nحافظ على صلاتك!',
                  style: const TextStyle(fontSize: 18, fontFamily: 'Amiri', color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                titleColor: Colors.green[700],
              ),
              SizedBox(height: 20.h),
              _buildCard(
                title: '📿 $azkarType الآن',
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarDetailsPage(
                              title: '$azkarType',
                              azkarType: '$type',
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.brown),
                    ),
                    Text(
                      'اقرأ $azkarType من هنا ',
                      style: const TextStyle(fontSize: 18, fontFamily: 'Amiri', color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                titleColor: Colors.purple[700],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget content, Color? titleColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor),
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}
