import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/image_storage.dart';
import 'package:quran_app/features/Home/presentation/widgets/students/storage.dart';
import 'package:quran_app/features/authentication/presentation/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherProfile extends StatefulWidget {
  final String username;
  final String? studentName;
  final String? email;

  const TeacherProfile({
    super.key,
    required this.username,
    this.studentName,
    required this.email,
  });

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  final ImageStorage _imageStorage = ImageStorage();
  final StudentStorage _studentStorage = StudentStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
  Uint8List? _imageData;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
      await _imageStorage.setImageData(widget.username, bytes);
    }
  }

  Future<void> _printStudentList() async {
    final students = await _studentStorage.getStudents(widget.username);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'قائمة الطلاب',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoKufiArabic',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xffa85000),
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffa85000), Color(0xffd97e33)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        students[index],
                        style: TextStyle(
                          fontFamily: 'NotoKufiArabic',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'إغلاق',
                style: TextStyle(
                  fontFamily: 'NotoKufiArabic',
                  fontSize: 18.sp,
                  color: Color(0xffa85000),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
    _emailController.text = widget.email!;
    _loadExistingData();
    _roleController.text = "معلم"; // Set the username
    _bioController.text = widget.username; // Set the user type
  }

  Future<void> _loadImage() async {
    final image = await _imageStorage.getImageData(widget.username);
    setState(() {
      _imageData = image;
    });
  }

  Future<void> _loadExistingData() async {
    final prefs = await SharedPreferences.getInstance();

    // Only update if there's saved data, otherwise keep the initial values
    if (prefs.containsKey('teacherPhone')) {
      _roleController.text = prefs.getString('teacherPhone') ?? 'معلم';
    }

    if (prefs.containsKey('teacherBio')) {
      _bioController.text = prefs.getString('teacherBio') ?? widget.username;
    }

    setState(() {});
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('teacherEmail', _emailController.text);
    await prefs.setString('teacherPhone', _roleController.text);
    await prefs.setString('teacherBio', _bioController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم حفظ البيانات بنجاح")),
    );
    Navigator.pop(context); // Corrected: Only pass context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyle(
            fontFamily: 'NotoKufiArabic',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffa85000), Color(0xffd97e33)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffa85000), Color(0xffd97e33)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: 60.h,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _imageData != null
                              ? MemoryImage(_imageData!)
                              : null,
                          child: _imageData == null
                              ? Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontFamily: 'NotoKufiArabic',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'معلم',
                        style: TextStyle(
                          fontFamily: 'NotoKufiArabic',
                          fontSize: 16.sp,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            // Info Cards Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.person,
                    title: 'المعلومات الشخصية',
                    content: 'عرض وتعديل المعلومات الشخصية',
                    gradientColors: [Color(0xffa85000), Color(0xffd97e33)],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(20.w),
                            child: Stack(
                              children: [
                                // Diagonal Background
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xffa85000), Color(0xffd97e33)],
                                      begin: Alignment.topRight, // Gradient from right to left
                                      end: Alignment.bottomLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'تعديل المعلومات الشخصية',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'NotoKufiArabic',
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                labelText: "البريد الإلكتروني",
                                                labelStyle: TextStyle(color: Colors.white),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                              ),
                                              style: TextStyle(color: Colors.white),
                                              validator: (value) => value!.isEmpty
                                                  ? "يجب إدخال البريد الإلكتروني"
                                                  : null,
                                            ),
                                            SizedBox(height: 10.h),
                                            TextFormField(
                                              controller: _bioController,
                                              decoration: InputDecoration(
                                                labelText: "اسم المستخدم",
                                                labelStyle: TextStyle(color: Colors.white),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                              ),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            SizedBox(height: 10.h),
                                            TextFormField(
                                              controller: _roleController,
                                              decoration: InputDecoration(
                                                labelText: "نوع المستخدم",
                                                labelStyle: TextStyle(color: Colors.white),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                              ),
                                              style: TextStyle(color: Colors.white),
                                              maxLines: 1,
                                              readOnly: true, // Make it read-only if user type shouldn't be changed
                                            ),
                                            SizedBox(height: 20.h),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!.validate()) {
                                                  _saveData();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30.w,
                                                  vertical: 10.h,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Text(
                                                "حفظ",
                                                style: TextStyle(
                                                  fontFamily: 'NotoKufiArabic',
                                                  fontSize: 18.sp,
                                                  color: Color(0xffa85000),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Close Button
                                Positioned(
                                  top: 10.w,
                                  left: 10.w, // Positioned on the top-left for RTL
                                  child: IconButton(
                                    icon: Icon(Icons.close, color: Colors.white, size: 24.w),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoCard(
                    icon: Icons.groups,
                    title: 'قائمة الطلاب',
                    content: 'عرض وإدارة قائمة الطلاب',
                    gradientColors: [Color(0xffa85000), Color(0xffd97e33)],
                    onTap: _printStudentList,
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'الجدول الزمني',
                    content: 'عرض الجدول الزمني للدروس',
                    gradientColors: [Color(0xffa85000), Color(0xffd97e33)],
                    onTap: () {
                      // Navigate to schedule screen
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoCard(
                    icon: Icons.settings,
                    title: 'الإعدادات',
                    content: 'تعديل إعدادات الحساب',
                    gradientColors: [Color(0xffa85000), Color(0xffd97e33)],
                    onTap: () {
                      // Navigate to settings screen
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            // Add the Subscribe button only if studentName is not null
            SizedBox(
              width: 220.w, // Set the same width for both buttons
              child: Column(
                children: [
                  // Add the Subscribe button only if studentName is not null
                  if (widget.studentName != null)
                    _buildActionButton(
                      text: 'اشتراك',
                      icon: Icons.star,
                      color: TextColors.darkBrown,
                      onTap: () async {
                        if (widget.studentName != null) {
                          await _studentStorage.addStudentToTeacher(
                            widget.username,
                            widget.studentName!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم إضافتك إلى قائمة طلاب المعلم'),
                            ),
                          );
                        }
                      },
                    ),
                  if (widget.studentName != null) SizedBox(height: 15.h), // Add spacing between buttons
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
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30.w,
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NotoKufiArabic',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'NotoKufiArabic',
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22.w),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'NotoKufiArabic',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}