import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class BackgroundVideoPlayer extends StatefulWidget {
  bool isMute = false;
  BackgroundVideoPlayer({super.key, required this.isMute});

  @override
  State<BackgroundVideoPlayer> createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  late final VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset('assets/videos/template.mp4')
          ..initialize().then((_) {
            setState(() {});
            videoPlayerController.setVolume(60);
            videoPlayerController.play();
            videoPlayerController.setLooping(true);
          });
  }

  @override
  Widget build(BuildContext context) {
    widget.isMute
        ? videoPlayerController.setVolume(0)
        : videoPlayerController.setVolume(60);
    return SizedBox.expand(
        child: FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: videoPlayerController.value.size.width,
        height: videoPlayerController.value.size.height,
        child: VideoPlayer(videoPlayerController),
      ),
    ));
  }
}
