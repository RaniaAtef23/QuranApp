import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:share_plus/share_plus.dart';
class VerseContainer extends StatefulWidget {
  const VerseContainer({super.key});

  @override
  _VerseContainerState createState() => _VerseContainerState();
}

class _VerseContainerState extends State<VerseContainer> {
  final List<String> _verses = [
    " أَلَمۡ یَأۡنِ لِلَّذِینَ ءَامَنُوۤا۟ أَن تَخۡشَعَ قُلُوبُهُمۡ لِذِكۡرِ ٱللَّهِ وَمَا نَزَلَ مِنَ ٱلۡحَقِّ وَلَا یَكُونُوا۟ كَٱلَّذِینَ أُوتُوا۟ ٱلۡكِتَـٰبَ مِن قَبۡلُ فَطَالَ عَلَیۡهِمُ ٱلۡأَمَدُ فَقَسَتۡ قُلُوبُهُمۡۖ وَكَثِیرࣱ مِّنۡهُمۡ فَـٰسِقُونَ﴾",
  "{رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ (147)} [آل عمران/147].",
    "{رَبَّنَا عَلَيْكَ تَوَكَّلْنَا وَإِلَيْكَ أَنَبْنَا وَإِلَيْكَ الْمَصِيرُ (4) رَبَّنَا لَا تَجْعَلْنَا فِتْنَةً لِلَّذِينَ كَفَرُوا وَاغْفِرْ لَنَا رَبَّنَا إِنَّكَ أَنْتَ الْعَزِيزُ الْحَكِيمُ (5)} [الممتحنة/4- 5].",
    "(یَوۡمَ یَقُولُ ٱلۡمُنَـٰفِقُونَ وَٱلۡمُنَـٰفِقَـٰتُ لِلَّذِینَ ءَامَنُوا۟ ٱنظُرُونَا نَقۡتَبِسۡ مِن نُّورِكُمۡ قِیلَ ٱرۡجِعُوا۟ وَرَاۤءَكُمۡ فَٱلۡتَمِسُوا۟ نُورࣰاۖ فَضُرِبَ بَیۡنَهُم بِسُورࣲ لَّهُۥ بَابُۢ بَاطِنُهُۥ فِیهِ ٱلرَّحۡمَةُ وَظَـٰهِرُهُۥ مِن قِبَلِهِ ٱلۡعَذَابُ یُنَادُونَهُمۡ أَلَمۡ نَكُن مَّعَكُمۡۖ قَالُوا۟ بَلَىٰ وَلَـٰكِنَّكُمۡ فَتَنتُمۡ أَنفُسَكُمۡ وَتَرَبَّصۡتُمۡ وَٱرۡتَبۡتُمۡ وَغَرَّتۡكُمُ ٱلۡأَمَانِیُّ حَتَّىٰ جَاۤءَ أَمۡرُ ٱللَّهِ وَغَرَّكُم بِٱللَّهِ ٱلۡغَرُورُ). [الحديد: 13-14]",
    "(إِنَّ ٱلَّذِینَ ءَامَنُوا۟ وَٱلَّذِینَ هَادُوا۟ وَٱلنَّصَـٰرَىٰ وَٱلصَّـٰبِـِٔینَ مَنۡ ءَامَنَ بِٱللَّهِ وَٱلۡیَوۡمِ ٱلۡـَٔاخِرِ وَعَمِلَ صَـٰلِحࣰا فَلَهُمۡ أَجۡرُهُمۡ عِندَ رَبِّهِمۡ وَلَا خَوۡفٌ عَلَیۡهِمۡ وَلَا هُمۡ یَحۡزَنُونَ). [البقرة: 62]",
    "(وَٱذۡكُرِ ٱسۡمَ رَبِّكَ وَتَبَتَّلۡ إِلَیۡهِ تَبۡتِیلࣰا رَّبُّ ٱلۡمَشۡرِقِ وَٱلۡمَغۡرِبِ لَاۤ إِلَـٰهَ إِلَّا هُوَ فَٱتَّخِذۡهُ وَكِیلࣰا وَٱصۡبِرۡ عَلَىٰ مَا یَقُولُونَ وَٱهۡجُرۡهُمۡ هَجۡرࣰا جَمِیلࣰا). [المزمل: 8-10]"


    // Add more verses as needed
  ];

  late String _randomVerse;

  @override
  void initState() {
    super.initState();
    _randomVerse = _verses[Random().nextInt(_verses.length)];
  }
  void _shareVerse() {
    print("Share button tapped"); // Debugging line
    Share.share(_randomVerse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network("assets/Home/bookmark.png"),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: _shareVerse, // Trigger sharing on tap
                      child: Image.network("assets/Home/ooui_share.png"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ايه اليوم",
                      style: TextStyles.font20darkBrownsemiBol,
                    ),
                    SizedBox(width: 10.w),
                    Image.network("assets/Home/aya.png"),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                _randomVerse,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
