import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/features/Home/presentation/HOME.dart';
import 'package:quran_app/features/Quran_recitation/presentation/quran_recitation_screen.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/quran_recitation_widgets/recitation_title.dart';
import 'package:quran_app/features/books/presentation/book_screen.dart';
import 'package:quran_app/features/compass/presentation/compass_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(), // Replace with other pages as needed
    BookListScreen(),
    QuranRecitationScreen(),
    QiblaDirectionPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home, size: 35.sp, color:Colors.white),
          Image.network('assets/main/ph_mosque.png', width: 35.sp, height: 35.sp),
          Image.network('assets/main/fluent-emoji-high-contrast_open-book.png', width: 30.sp, height: 30.sp),
          Image.network('assets/main/icon-park-outline_two-hands.png', width: 30.sp, height: 30.sp),
          Image.network('assets/main/ep_setting.png', width: 30.sp, height: 30.sp),


        ],
        index: _selectedIndex,
        color:TextColors.darkbrown2,
        buttonBackgroundColor: TextColors.darkbrown2,
        backgroundColor:Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
        height: 55.h,
      ),
    );
  }
}
