import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/Home/data/manager/surah_cubit/surah_cubit.dart';
import 'package:quran_app/features/Home/presentation/widgets/surah/aya_screen.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure getAllSurahs is called when the screen is loaded
    context.read<SurahCubit>().getAllSurahs();

    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        debugPrint('Current State: $state'); // Debug the current state
        if (state is SurahLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurahError) {
          return Center(child: Text(state.message));
        } else if (state is SurahLoaded) {
          return ListView.builder(
            itemCount: state.surahs.length,
            itemBuilder: (context, index) {
              final surah = state.surahs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfff7b15c), // Lighter shade
                            Color(0xffe68a00), // Your original color
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              Icons.book,
                              color: Color(0xffe68a00),
                              size: 30,
                            ),
                          ),
                          title: Text(
                            '${surah.name}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Surah Number: ${surah.number}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white70,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AyahScreen(surahNumber: surah.number, surahName: surah.name,),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No Surahs found.'));
        }
      },
    );
  }
}
