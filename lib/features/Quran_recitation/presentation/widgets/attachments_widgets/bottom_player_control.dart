import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BottomPlayerControl extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final String? currentPlayingUrl;
  final List<dynamic> attachments;

  const BottomPlayerControl({
    Key? key,
    required this.audioPlayer,
    required this.currentPlayingUrl,
    required this.attachments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentPlayingUrl != null
                ? attachments.firstWhere(
                    (attachment) => attachment['url'] == currentPlayingUrl)['title'] ??
                'Untitled'
                : 'Select a track to play',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Slider(
            thumbColor: Colors.orange[900],
            activeColor: Colors.orange,
            inactiveColor: Colors.grey,
            min: 0.0,
            max: audioPlayer.duration?.inSeconds.toDouble() ?? 0.0,
            value: audioPlayer.position.inSeconds.toDouble().clamp(
              0.0,
              audioPlayer.duration?.inSeconds.toDouble() ?? 0.0,
            ),
            onChanged: (value) {
              audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildControlButton(
                icon: Icons.skip_previous,
                onPressed: () {
                  final currentIndex = attachments.indexWhere(
                        (attachment) => attachment['url'] == currentPlayingUrl,
                  );
                  if (currentIndex > 0) {
                    final previousAttachment = attachments[currentIndex - 1];
                    audioPlayer.setUrl(previousAttachment['url']);
                    audioPlayer.play();
                  }
                },
              ),
              _buildPlayPauseButton(),
              _buildControlButton(
                icon: Icons.skip_next,
                onPressed: () {
                  final currentIndex = attachments.indexWhere(
                        (attachment) => attachment['url'] == currentPlayingUrl,
                  );
                  if (currentIndex < attachments.length - 1) {
                    final nextAttachment = attachments[currentIndex + 1];
                    audioPlayer.setUrl(nextAttachment['url']);
                    audioPlayer.play();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 30.0),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final isPlaying = playerState?.playing ?? false;

          return IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              if (isPlaying) {
                audioPlayer.pause();
              } else {
                audioPlayer.play();
              }
            },
          );
        },
      ),
    );
  }
}
