import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/core/networking/repo/prayer_repo.dart';
import 'package:quran_app/core/networking/repo/prayer_repo_impl.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/data/model/hejri_date.dart';
import 'package:quran_app/features/Home/data/model/melady_date.dart';
import 'package:quran_app/features/Home/data/model/meta_model.dart';
import 'package:quran_app/features/Home/data/model/prayer_time_model.dart';
import 'package:quran_app/features/Home/presentation/widgets/azkar/azkar_page.dart';
import 'package:quran_app/features/Home/presentation/widgets/calender/calender_screen.dart';
import 'package:quran_app/features/Home/presentation/widgets/home_widget/_HeaderSection.dart';
import 'package:quran_app/features/Home/presentation/widgets/home_widget/main_content.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/Data_info.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/circular_slider.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/display_pray_times.dart';
import 'package:quran_app/features/Home/presentation/widgets/pray_time&date/time_zone_info.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/Feature_icon.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/hadeth_container.dart';
import 'package:quran_app/features/Home/presentation/widgets/random_containers/verse_container.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/student_profile.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_list.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_profile.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/teacher_provider.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/image_storage.dart';
import 'package:quran_app/features/Home/presentation/widgets/surah/surah_screen.dart';
import 'package:quran_app/features/Home/presentation/widgets/tasbeeh/Tasbeh_page.dart';

class HomePageContent extends StatefulWidget {
  final HijriDateModel hijriDate;
  final GregorianModel meladeDate;
  final MetaModel metaData;
  final String userType;
  final String userName;
  final String email;

  const HomePageContent({
    super.key,
    required this.hijriDate,
    required this.meladeDate,
    required this.metaData,
    required this.userName,
    required this.userType,
    required this.email,
  });

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final ImageStorage _imageStorage = ImageStorage();
  Uint8List? _profileImage;
  late Timer _checkTimer;
  late AudioPlayer _audioPlayer;
  final PrayerRepository _repo = PrayerRepositoryImpl();
  Map<String, TimeOfDay> _prayerTimes = {};
  String? studentName;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPrayerTimes();
      if (widget.userType == "معلم") {
        final String tech_email=widget.email;
        Provider.of<TeacherProvider>(context, listen: false).addTeacher(widget.userName, tech_email);
      } else {
        studentName = widget.userName;
      }
    });
    _checkTimer = Timer.periodic(const Duration(minutes: 1), (_) => checkPrayerTime());
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final image = await _imageStorage.getImageData(widget.userName);
    setState(() {
      _profileImage = image;
    });
  }

  @override
  void dispose() {
    _checkTimer.cancel();
    _audioPlayer.dispose();
    super.dispose();
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
          _initializePrayerTimes(prayerTimings);
        });
      }
    } catch (e) {
      debugPrint('Error fetching prayer times: $e');
    }
  }

  void _initializePrayerTimes(Timings timings) {
    _prayerTimes = {
      "الفجر": _parseTime(timings.fajr),
      "الشروق": _parseTime(timings.sunrise),
      "الظهر": _parseTime(timings.dhuhr),
      "العصر": _parseTime(timings.asr),
      "المغرب": _parseTime(timings.maghrib),
      "العشاء": _parseTime(timings.isha),
    };
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(":");
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1].split(" ")[0]),
    );
  }

  void checkPrayerTime() {
    final now = TimeOfDay.fromDateTime(DateTime.now());
    for (var entry in _prayerTimes.entries) {
      if (now.hour == entry.value.hour && now.minute == entry.value.minute) {
        playAzan();
        showPrayerAlert(entry.key);
        break;
      }
    }
  }

  Future<void> playAzan() async {
    try {
      await _audioPlayer.setAsset('assets/audio/019--1.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing Azan: $e');
    }
  }

  void showPrayerAlert(String prayerName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('حان وقت اذان $prayerName', textAlign: TextAlign.center),
          content: const Text('يُفضل أن تؤدي الصلاة الآن.', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                _audioPlayer.stop();
                Navigator.pop(context);
              },
              child: const Text(
                'إيقاف الأذان',
                style: TextStyle(color: TextColors.darkBrown, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(
              hijriDate: widget.hijriDate,
              meladeDate: widget.meladeDate,
              metaData: widget.metaData,
              userName: widget.userName,
              userType: widget.userType,
              email: widget.email,
              profileImage: _profileImage,
              onProfileTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.userType == "معلم"
                        ? TeacherProfile(username: widget.userName, email: widget.email)
                        : StudentProfile(username: widget.userName, Email: widget.email,),
                  ),
                ).then((_) {
                  setState(() {
                    _loadProfileImage();
                  });
                });
              },
            ),
            MainContent(
              userType: widget.userType,
              studentName: studentName,
              email: widget.email,
            ),
          ],
        ),
      ),
    );
  }
}