import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/attachments_widgets/AttachmentList.dart';
import 'package:quran_app/features/Quran_recitation/presentation/widgets/attachments_widgets/bottom_player_control.dart';
import 'package:quran_app/features/onboarding/presentation/widgets/Onboarding_widgets/onboarding_image.dart';


class AttachmentsScreen extends StatefulWidget {
  final List<dynamic> attachments;

  const AttachmentsScreen({super.key, required this.attachments});

  @override
  _AttachmentsScreenState createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPlayingUrl;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attachments',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          const BackgroundImage(imageUrl: 'assets/OnBoarding/onboarding.png',),
          widget.attachments.isNotEmpty
              ? AttachmentList(
            attachments: widget.attachments,
            audioPlayer: _audioPlayer,
            currentPlayingUrl: _currentPlayingUrl,
            onPlay: (url) {
              setState(() {
                _currentPlayingUrl = url;
              });
              // Add your play audio logic here
            },
          )
              : const Center(
            child: Text(
              'No attachments available',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPlayerControl(
        audioPlayer: _audioPlayer,
        currentPlayingUrl: _currentPlayingUrl,
        attachments: widget.attachments,
      ),
    );
  }
}
