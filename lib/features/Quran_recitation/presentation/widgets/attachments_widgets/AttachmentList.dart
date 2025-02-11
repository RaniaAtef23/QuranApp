import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AttachmentList extends StatefulWidget {
  final List<dynamic> attachments;
  final AudioPlayer audioPlayer;
  final String? currentPlayingUrl;
  final Function(String) onPlay;

  const AttachmentList({
    Key? key,
    required this.attachments,
    required this.audioPlayer,
    required this.currentPlayingUrl,
    required this.onPlay,
  }) : super(key: key);

  @override
  _AttachmentListState createState() => _AttachmentListState();
}

class _AttachmentListState extends State<AttachmentList> {
  Map<int, bool> _isTapped = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.attachments.length,
      itemBuilder: (context, index) {
        final attachment = widget.attachments[index];
        final title = attachment['title'] ?? 'Untitled';
        final url = attachment['url'] ?? '';

        return GestureDetector(
          onTap: () {
            setState(() {
              _isTapped.updateAll((key, value) => false); // Reset all taps
              _isTapped[index] = true; // Set current index as tapped
            });

            if (url.isNotEmpty) {
              widget.onPlay(url);
              widget.audioPlayer.setUrl(url).then((_) => widget.audioPlayer.play());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No URL available')),
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _isTapped[index] ?? false
                  ? Colors.orange.withOpacity(0.8)
                  : Colors.transparent,
              border: Border.all(color: Colors.orange, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
