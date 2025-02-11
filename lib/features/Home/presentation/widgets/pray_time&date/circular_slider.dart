import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'dart:async';

class CircularSlider extends StatefulWidget {
  final void Function(DateTime)? onTimeChanged; // Add this line

  const CircularSlider({super.key, this.onTimeChanged}); // Updated constructor

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  final PrayerRepository _repo = PrayerRepositoryImpl();
  Timings? _prayerTimings;
  DateTime currentTime = DateTime.now();
  String prayerText = "الثلث الاخير";
  double radialValue = 100.0;
  String? difference;
  final Map<String, DateTime?> prayerTimes = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      final prayerTimings = await _repo.fetchPrayerTimings(
        date: '15-02-2024',
        country: 'Egypt',
        city: 'Cairo',
      );

      if (prayerTimings != null) {
        setState(() {
          _prayerTimings = prayerTimings;
          _initializePrayerTimes();
          _updateTime();
        });
      }
    } catch (e) {
      debugPrint('Error fetching prayer times: $e');
    }
  }

  void _initializePrayerTimes() {
    if (_prayerTimings != null) {
      prayerTimes.addAll({
        "الفجر": _parseTime(_prayerTimings!.fajr),
        "الشروق": _parseTime(_prayerTimings!.sunrise),
        "الظهر": _parseTime(_prayerTimings!.dhuhr),
        "العصر": _parseTime(_prayerTimings!.asr),
        "الغروب": _parseTime(_prayerTimings!.sunset),
        "المغرب": _parseTime(_prayerTimings!.maghrib),
        "العشاء": _parseTime(_prayerTimings!.isha),
        "الثلث الاول": _parseTime(_prayerTimings!.firstThird),
        "الثلث الاخير": _parseTime(_prayerTimings!.lastThird),
      });
    }
  }

  DateTime? _parseTime(String? timeString) {
    if (timeString == null) return null;
    try {
      final parsedTime = DateFormat('HH:mm').parse(timeString);
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      debugPrint('Error parsing time: $e');
      return null;
    }
  }

  void _updateTime() {
    final now = DateTime.now();
    DateTime? nextPrayerTime;
    String? nextPrayerName;

    for (var entry in prayerTimes.entries) {
      if (entry.value != null && now.isBefore(entry.value!)) {
        nextPrayerName = entry.key;
        nextPrayerTime = entry.value;
        break;
      }
    }

    if (nextPrayerTime != null) {
      final remainingDuration = nextPrayerTime.difference(now);
      setState(() {
        currentTime = now;
        prayerText = nextPrayerName!;
        radialValue = _calculateRadialValue(nextPrayerName);
        difference = _formatTimeDifference(remainingDuration);
      });

      // Invoke the callback
      if (widget.onTimeChanged != null) {
        widget.onTimeChanged!(currentTime);
      }
    }
  }

  double _calculateRadialValue(String prayerName) {
    const prayerPositions = {
      "الفجر": 0.0,
      "الشروق": 10.0,
      "الظهر": 20.0,
      "العصر": 30.0,
      "الغروب": 50.0,
      "المغرب": 60.0,
      "العشاء": 70.0,
      "الثلث الاول": 80.0,
      "الثلث الاخير": 90.0,
    };
    return prayerPositions[prayerName] ?? 0.0;
  }

  String _formatTimeDifference(Duration difference) {
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;
    return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            maximum: 100,
            startAngle: 180,
            endAngle: 360,
            showLabels: false,
            showTicks: false,
            radiusFactor: 1.3,
            axisLineStyle: const AxisLineStyle(
              thickness: 6,
              cornerStyle: CornerStyle.bothCurve,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: radialValue,
                cornerStyle: CornerStyle.bothCurve,
                width: 8,
                color: TextColors.darkbrown2,
              ),
              MarkerPointer(
                value: radialValue,
                markerHeight: 12.h,
                markerWidth: 12.w,
                color: TextColors.darkBrown,
                markerType: MarkerType.circle,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 270,
                positionFactor: 0.3,
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(prayerText, style: TextStyles.font16semiBolddarkbrown),
                    Text(DateFormat('h:mm a').format(currentTime),
                        style: TextStyles.font14mediumdarkbrown2),
                  ],
                ),
              ),
              GaugeAnnotation(
                angle: 270,
                positionFactor: 0,
                widget: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Text(
                    "-${difference ?? "N/A"}",
                    style: TextStyles.font14mediumdarkbrown,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
