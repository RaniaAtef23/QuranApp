import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/resources/styles.dart';
import 'package:share_plus/share_plus.dart';
class HadethContainer extends StatefulWidget {
  const HadethContainer({super.key});

  @override
  _HadethContainerState createState() => _HadethContainerState();
}

class _HadethContainerState extends State<HadethContainer> {
  final List<String> _Hadeths = [
    "قال رسول الله صلى الله عليه وسلم: (إنَّ مِن أحبِّكم إليَّ وأقربِكُم منِّي مجلسًا يومَ القيامةِ أحاسنَكُم أخلاقًا)",
    " «اجتنبوا السبع الموبقات: الشرك بالله، والسحر، وقتل النفس التي حرَّم الله إلا بالحق، وأكل الربا وأكل مال اليتيم، والتولي يوم الزحف، وقذف المُحْصَنات الغافلات»(عن أبي هريرة، أخرجه الشيخان).",
    " «البِرُّ حسن الخلق، والإثم ما حاك في صدرك وكرهت أن يطلع عليه الناس»(عن النوّاس بن سمعان، أخرجه مسلم).",
    "«إذا التقى المسلمان بسيفهما فقتل أحدهما صاحبه، فالقاتل والمقتول في النار»، قيل: يا رسول الله هذا القاتل فما بال المقتول؟ قال: «إنه كان حريصا على قتل صاحبه»(عن أبي بكرة، رواه الشيخان).",
    "«ألا أنبئكم بأكبر الكبائر: الإشراك بالله، وعقوق الوالدين، وقول الزور»(عن علِيّ رضي الله عنه، رواه الشيخان).",
    " «آية المنافق ثلاث إذا حدَّث كذّب، وإذا وعد أخلف، وإذا ائتمن خان»(عن أبي هريرة، رواه الشيخان)"

    // Add more verses as needed
  ];

  late String _randomHadeth;

  @override
  void initState() {
    super.initState();
    _randomHadeth = _Hadeths[Random().nextInt(_Hadeths.length)];
  }
  void _shareHadeth() {
    print("Share button tapped"); // Debugging line
    Share.share(_randomHadeth);
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
                      onTap: _shareHadeth, // Trigger sharing on tap
                      child: Image.network("assets/Home/ooui_share.png"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "حديث اليوم",
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
                _randomHadeth,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
