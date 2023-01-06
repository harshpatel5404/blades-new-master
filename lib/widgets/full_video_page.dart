import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullVideoPage extends StatefulWidget {
  final String videoUrl;
  final bool isPlayvideo;

  const FullVideoPage(
      {Key? key, required this.videoUrl, required this.isPlayvideo})
      : super(key: key);

  @override
  State<FullVideoPage> createState() => _FullVideoPageState();
}

class _FullVideoPageState extends State<FullVideoPage> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((value) {
        setState(() {
          widget.isPlayvideo
              ? videoPlayerController.play()
              : videoPlayerController.pause();
          videoPlayerController.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(videoPlayerController);
  }
}
