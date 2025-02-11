import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/Home/presentation/widgets/azkar/azkar_datails.dart';

class AzkarPage extends StatelessWidget {
  final List<Map<String, String>> azkar = [
    {'title': 'أذكار الصباح', 'image': 'assets/Home/morning.png'},
    {'title': 'أذكار المساء', 'image': 'assets/Home/night.png'},
    {'title': 'دعاء السفر', 'image': 'assets/Home/travel.png'},
    {'title': 'دعاء النوم', 'image': 'assets/Home/sleep.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الأذكار",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfff8c471), Color(0xfff39c12)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 40.h,left: 12.w,right: 12.w),
        child: GridView.builder(
          itemCount: azkar.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if(azkar[index]['title']=='أذكار الصباح'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarDetailsPage(
                        title: azkar[index]['title']!,
                        azkarType: 'morning',
                      ),
                    ),
                  );
                }
                else if(azkar[index]['title']=='أذكار المساء'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarDetailsPage(
                        title: azkar[index]['title']!,
                        azkarType: 'evening',
                      ),
                    ),
                  );

                }
                else if(azkar[index]['title']=='دعاء النوم'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarDetailsPage(
                        title: azkar[index]['title']!,
                        azkarType: 'sleep',
                      ),
                    ),
                  );
                }
                else if(azkar[index]['title']=='دعاء السفر'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarDetailsPage(
                        title: azkar[index]['title']!,
                        azkarType: 'travel',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(azkar[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    azkar[index]['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

