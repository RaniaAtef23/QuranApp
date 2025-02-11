import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_cubit.dart';
import 'package:quran_app/features/Home/data/manager/prayer_cubit/prayer_state.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
class PrayerTimes extends StatefulWidget {
  const PrayerTimes({super.key});

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  final PrayerRepository _repo = PrayerRepositoryImpl();
  Timings? _prayerTimings;
  Map<String, String> prayerTimes = {}; // Declare the prayerTimes map to store prayer names and times

  @override
  void initState() {
    super.initState();
    context.read<PrayerCubit>().fetchPrayerData();
    _fetchPrayerTimes();
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

  String _parseTime(String time) {
    return time ?? "غير متوفر";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مواقيت الصلاة",
          style: TextStyle(fontFamily: 'Amiri', fontSize: 22.sp),
        ),
        backgroundColor: const Color(0xffa85000).withOpacity(0.8),
      ),
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerError) {
            return Center(child: Text(state.message));
          } else if (state is PrayerLoaded) {
            return SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [
                    // Background image with blur effect
                    Positioned.fill(
                      child: Image.asset(
                        'assets/Home/Frame 3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay for text readability
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Section
                          Text(
                            "مواقيت الصلاة لهذا اليوم",
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // Hijri Date Section
                          Text(
                            ' ${state.hijriDate.weekday.ar ?? ''} ',
                            style: TextStyle(
                                fontSize:30.sp,
                                color: Colors.white,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            ' ${state.hijriDate.day ?? ''}${state.hijriDate.month.ar ?? ''}${state.hijriDate.year?? ''} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // Displaying prayer times with modern UI elements
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: prayerTimes.length,
                            itemBuilder: (context, index) {
                              String prayerName = prayerTimes.keys.elementAt(index);
                              String prayerTime = prayerTimes.values.elementAt(index);

                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                color: const Color(0xffa85000).withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 8,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Use icons to represent prayer types
                                      _getPrayerIcon(prayerName),
                                      Text(
                                        prayerName,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Amiri',
                                        ),
                                      ),
                                      Text(
                                        prayerTime,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Amiri',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _getPrayerIcon(String prayerName) {
    IconData icon;
    switch (prayerName) {
      case 'الفجر':
        icon = Icons.brightness_5;
        break;
      case 'الشروق':
        icon = Icons.wb_sunny;
        break;
      case 'الظهر':
        icon = Icons.access_time;
        break;
      case 'العصر':
        icon = Icons.access_alarm;
        break;
      case 'الغروب':
        icon = Icons.sunny;
        break;
      case 'المغرب':
        icon = Icons.brightness_3;
        break;
      case 'العشاء':
        icon = Icons.nightlight_round;
        break;
      default:
        icon = Icons.access_time;
    }
    return Icon(
      icon,
      color: Colors.white,
      size: 28.sp,
    );
  }
}
