import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailsPage extends StatefulWidget {
  final String title;
  final String azkarType;

  const AzkarDetailsPage({
    Key? key,
    required this.title,
    required this.azkarType,
  }) : super(key: key);

  @override
  _AzkarDetailsPageState createState() => _AzkarDetailsPageState();
}

class _AzkarDetailsPageState extends State<AzkarDetailsPage> {
  late List<Map<String, dynamic>> azkarDetails;

  List<Map<String, dynamic>> alsabahazkar = [
    {
      'text': 'اللّهُـمَّ أَنْتَ رَبِّـي لا إلهَ إِلاّ أَنْتَ، خَلَقْتَنـي وَأَنَا عَبْـدُك، وَأَنَا عَلـى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْـتُ، أَعـوذُ بِكَ مِنْ شَـرِّ مَا صَنَعْـتُ، أَبـوءُ لَكَ بِنِعْمَتِـكَ عَلَـيَّ، وَأَبـوءُ بِذَنْـبي فَاغْفِـرْ لي، فَإِنَّهُ لا يَغْفِـرُ الذُّنـوبَ إِلاَّ أَنْتَ.',
      'count': 1
    },
    {
      'text': 'اللّهُـمَّ إِنِّي أَصْبَـحْتُ أُشْـهِدُكَ، وَأُشْـهِدُ حَمَـلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لا إِلَـهَ إِلاَّ أَنْتَ، وَحْدَكَ لا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.',
      'count': 4
    },
    {
      'text': 'اللّهُـمَّ عافِنـي في بَدَنـي، اللّهُـمَّ عافِنـي في سَمْعـي، اللّهُـمَّ عافِنـي في بَصَـري، لا إلهَ إلاّ أَنْـتَ.',
      'count': 3
    },
    {
      'text': 'حَسْبِـيَ اللَّهُ لا إلهَ إلاّ هُوَ، عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.',
      'count': 7
    },
    {
      'text': 'بِسْمِ اللهِ الَّذِي لا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
      'count': 3
    },
    {
      'text': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ.',
      'count': 100
    },
    {
      'text': 'رَضِيتُ بِاللهِ رَبًّا وَبِالإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا.',
      'count': 3
    },
    {
      'text': 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ أَنْتَ الْمَلِكُ لاَ إِلَهَ إِلاَّ أَنْتَ، حَسْبِيَ اللَّهُ لاَ شَرِيكَ لَكَ.',
      'count': 1
    },
    {
      'text': 'اللّهُـمَّ ما أَصْبَـحَ بي مِـن نِعْـمَةٍ أَوْ بِأَحَـدٍ مِـنْ خَلْقِـكَ، فَمِـنْكَ وَحْدَكَ لا شَـريكَ لَـكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْـرُ.',
      'count': 1
    },
    {
      'text': 'أَعُوذُ بِكَلِمَاتِ اللّهِ التّامّاتِ مِنْ شَرِّ مَا خَلَقَ.',
      'count': 3
    },
    {
      'text': 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ.',
      'count': 10
    },
    {
      'text': 'اللّهُـمَّ إِنِّي أَسْـأَلُكَ خَـيْرَ هَذَا الْـيَوْمِ فَتْحَهُ وَنَصْرَهُ، وَنُورَهُ وَبَرَكَتَهُ وَهُدَاهُ.',
      'count': 1
    },
    {
      'text': 'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشَّـهادَةِ، فاطِـرَ السَّماواتِ وَالأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ.',
      'count': 1
    },
    {
      'text': 'أَصْبَـحْنا وَأَصْبَـحَ المـلْكُ للهِ، وَالحَمْـدُ للهِ، لا إلهَ إلاّ اللَّهُ وَحْـدَهُ لا شَريكَ لَـهُ.',
      'count': 1
    },
    {
      'text': 'لا إلهَ إلاّ اللهُ وَحْـدَهُ لا شَريكَ لَـهُ، لَـهُ الْمُلْكُ وَلَـهُ الحَمْدُ، وَهُوَ عَلى كُلِّ شَيْءٍ قَدير.',
      'count': 10
    },
    {
      'text': 'سُبْحَانَ اللهِ وَالْحَمْدُ لِلَّهِ، وَاللَّهُ أَكْبَرُ.',
      'count': 33
    },
    {
      'text': 'اللَّهُ أَكْبَرُ.',
      'count': 34
    },
  ];
  List<Map<String, dynamic>> almasaAzkar = [

    {
      'text': 'أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر. ',
      'count': 1
    },
    {
      'text': 'أَعُوذُ بِكَلِمَاتِ اللّهِ التّامّاتِ مِنْ شَرِّ مَا خَلَقَ.',
      'count': 3
    },
    {
      'text': 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ.',
      'count': 10
    },
    {
      'text': 'سُبْحَانَ اللهِ وَالْحَمْدُ لِلَّهِ، وَاللَّهُ أَكْبَرُ.',
      'count': 33
    },
    {
      'text': 'اللَّهُ أَكْبَرُ.',
      'count': 34
    },

  ];
  List<Map<String, dynamic>> sleepAzkar = [
    {
      'text': 'اللّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
      'count': 1
    },
    {
      'text': 'اللّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبعَثُ عِبَادَكَ',
      'count': 3
    },
    {
      'text': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
      'count': 100
    },
    {
      'text': 'اللّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
      'count': 10
    },
  ];
  List<Map<String, dynamic>> travelDoaa = [
    {
      'text': 'اللّهُمَّ إِنِّي أَسْأَلُكَ فِي سَفَرِي هَذَا البَرَكَةَ فِيهِ',
      'count': 1
    },
    {
      'text': 'اللّهُمَّ أَنتَ الصَّاحِبُ فِى السَّفَرِ وَالخَلِيفَةُ فِى الأَهْلِ',
      'count': 3
    },
    {
      'text': 'اللّهُمَّ اجْعَلْهُ رِحْلَةً مُّبَارَكَةً',
      'count': 1
    },
    {
      'text': 'اللّهُمَّ اجْعَلْنَا مِنْ أَهْلِ الجَنَّةِ',
      'count': 10
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.azkarType == 'morning') {
      azkarDetails = alsabahazkar;
    } else if (widget.azkarType == 'evening') {
      azkarDetails = almasaAzkar;
    } else if (widget.azkarType == 'sleep') {
      azkarDetails = sleepAzkar;
    } else if (widget.azkarType == 'travel') {
      azkarDetails = travelDoaa;
    }
  }

  void _checkCompletion() {
    if (azkarDetails.every((azkar) => azkar['count'] <= 0)) {
      showDialog(
        context: context,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade100, Colors.orange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(  // Make the content scrollable
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: -0.1,
                      child: Image.network(
                        'assets/Home/star.png',
                        height: 80.h,
                        width: 80.w,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      "مبروك!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "لقد أنهيت جميع أذكار ${widget.azkarType}🎉", // Ensure you use 'widget' here.
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "حسناً",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xfff8c471),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: azkarDetails.length,
                itemBuilder: (context, index) {
                  final azkar = azkarDetails[index];

                  if (azkar['count'] <= 0) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.teal.shade50,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                      title: Text(
                        azkar['text'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xfff39c12),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          azkar['count'].toString(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          azkar['count']--;
                        });
                        _checkCompletion();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
