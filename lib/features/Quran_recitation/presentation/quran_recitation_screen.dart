import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/Quran_recitation/data/manager/quran_recitation_cubit.dart';
import 'package:quran_app/features/Quran_recitation/data/manager/quran_recitation_state.dart';
import 'package:quran_app/features/Quran_recitation/presentation/attchment_screen.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/quran_recitation_widgets/recitation_title.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/quran_recitation_widgets/error_messege.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/quran_recitation_widgets/recitation_item.dart';
class QuranRecitationScreen extends StatefulWidget {
  const QuranRecitationScreen({super.key});

  @override
  _QuranRecitationScreenState createState() => _QuranRecitationScreenState();
}

class _QuranRecitationScreenState extends State<QuranRecitationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the recitation data
    context.read<QuranRecitationCubit>().fetchQuranRecitation();
  }

  Future<void> fetchAttachments(String recitationId) async {
    final url =
        'https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/quran/get-recitation/$recitationId/ar/json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final attachments = data['attachments'] ?? [];

        // Navigate to the AttachmentsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttachmentsScreen(attachments: attachments),
          ),
        );
      } else {
        throw Exception('Failed to load attachments');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'خطأ',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'تعذر تحميل المرفقات: $e',
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 16.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('إغلاق', textDirection: TextDirection.rtl),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuranRecitationCubit, QuranRecitationState>(
        builder: (context, state) {
          if (state is QuranRecitationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuranRecitationLoaded) {
            final recitations = state.recitations;

            return ListView.builder(
              itemCount: recitations.length + 1, // +1 for the title
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const RecitationTitle();
                }

                final recitation = recitations[index - 1]; // Adjust for title offset

                return RecitationItem(
                  recitation: recitation,
                  onTap: fetchAttachments,
                );
              },
            );
          } else if (state is QuranRecitationError) {
            return ErrorMessage(message: state.message);
          }

          return const Center(
            child: Text(
              'لا توجد تلاوات متاحة',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
