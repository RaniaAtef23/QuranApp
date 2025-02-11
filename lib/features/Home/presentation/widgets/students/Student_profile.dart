import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/image_storage.dart';
import 'package:quran_app/features/Type/presentation/UserTypePage.dart';
import 'package:quran_app/features/authentication/presentation/auth_screen.dart';
class StudentProfile extends StatefulWidget {
  final String username;
  final String studentImage;
  final int completedSurahs;
  final int totalSurahs;
  final int memorizedAyahs;
  final int totalAyahs;
  final String currentSurah;
  final String currentAyah;
  final int progressPercentage;
  final String ?Email; // ✅ Keep as a named parameter

  const StudentProfile({
    super.key,
    required this.username,
    this.studentImage = '',
    this.completedSurahs = 0,
     required this.Email,
  this.totalSurahs = 114,
    this.memorizedAyahs = 0,
    this.totalAyahs = 6236,
    this.currentSurah = 'السورة الحالية',
    this.currentAyah = 'الآية الحالية',
    this.progressPercentage = 0,
  });

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}



class _StudentProfileState extends State<StudentProfile> {
  final ImageStorage _imageStorage = ImageStorage();
  Uint8List? _imageData;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() => _imageData = bytes);
      await _imageStorage.setImageData(widget.username, bytes);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final image = await _imageStorage.getImageData(widget.username);
    setState(() => _imageData = image);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> counters = _imageStorage.counters;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffa85000),
        title: Text('ملف الطالب', style: TextStyle(color: Colors.white, fontSize: 20.sp)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageData != null ? MemoryImage(_imageData!) : null,
                child: _imageData == null ? const Icon(Icons.person, size: 50) : null,
              ),
            ),
            SizedBox(height: 24.h),
            Text(widget.username, style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 24.h),
            _buildProgressBar(widget.progressPercentage),
            SizedBox(height: 24.h),
            _buildStatCard('السور المحفوظة', '${widget.completedSurahs}/${widget.totalSurahs}'),
            _buildStatCard('السورة الحالية', widget.currentSurah),
            SizedBox(height: 24.h),
            Text('تقرير التسبيح', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: counters.length,
              itemBuilder: (context, index) {
                final tasbeeh = counters.keys.elementAt(index);
                final count = counters.values.elementAt(index);
                return ListTile(

                  title:Text("$count/100", style: TextStyle(fontSize: 16.sp, color: const Color(0xffa85000), fontWeight: FontWeight.bold)) ,
                  trailing:Text(tasbeeh, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)) ,
                );
              },
            ),
            SizedBox(height: 24.h),
            _buildButton('ابدأ الحفظ', const Color(0xffa85000), () {}),
            SizedBox(height: 16.h),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: TextColors.darkBrown,
                  width: 2.0,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31.r),
                ),
                minimumSize: Size(double.infinity, 48.h), // Set the same height for both buttons
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  'تسجيل الخروج',
                  style: TextStyles.font20darkBrownRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 18.sp, color: const Color(0xffa85000), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('التقدم', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Stack(
          children: [
            Container(
              height: 15.h,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
            ),
            Container(
              height: 15.h,
              width: (percentage / 100) * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [Color(0xffa85000), Color(0xFF832EE5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text('$percentage%', style: TextStyle(fontSize: 18.sp, color: const Color(0xffa85000), fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
