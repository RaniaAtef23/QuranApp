import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/features/Home/data/manager/surah_cubit/surah_cubit.dart';

class AyahScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const AyahScreen({super.key, required this.surahNumber, required this.surahName});

  @override
  _AyahScreenState createState() => _AyahScreenState();
}

class _AyahScreenState extends State<AyahScreen> {
  @override
  void initState() {
    super.initState();
    // Load the surah by its number
    context.read<SurahCubit>().getSurahByNumber(widget.surahNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
        backgroundColor: const Color(0xffe68a00), // Match with previous color
      ),
      body: BlocBuilder<SurahCubit, SurahState>(
        builder: (context, state) {
          if (state is SurahLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SurahError) {
            return Center(child: Text(state.message));
          } else if (state is SpecificSurahLoaded) {
            return Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/Home/shadow-tropical-plant-wall.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Content Area with Padding and Shadow
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0.h, horizontal: 2.0.w),
                  child: Center(
                    child: Container(
                      width: 320.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Semi-transparent background
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true, // Ensures ListView adapts its size
                        itemCount: state.surah.ayahs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontFamily: 'Tajawal',
                                  ),
                                  children: [
                                    // Ayah Text
                                    TextSpan(
                                      text: '${state.surah.ayahs[index].text} ',
                                    ),
                                    // Ayah Number inside a circular bracket
                                    TextSpan(
                                      text: '(${state.surah.ayahs[index].numberInSurah})',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: TextColors.darkBrown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No Ayahs available.'));
          }
        },
      ),
    );
  }
}
