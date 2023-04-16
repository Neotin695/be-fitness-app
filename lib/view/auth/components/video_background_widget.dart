import 'package:flutter/foundation.dart';
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
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      videoPlayerController = VideoPlayerController.network(
          'https://firebasestorage.googleapis.com/v0/b/be-fitness-4ca28.appspot.com/o/background%20video%2Ftemplate.mp4?alt=media&token=74ba7556-02c6-42d7-a48c-4738044a1000')
        ..initialize().then((_) {
          setState(() {});
        });
    } else {
      videoPlayerController =
          VideoPlayerController.asset('assets/videos/template.mp4')
            ..initialize().then((_) {
              setState(() {});
              videoPlayerController.setVolume(60);
              videoPlayerController.play();
              videoPlayerController.setLooping(true);
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.isMute
        ? videoPlayerController.setVolume(0)
        : videoPlayerController.setVolume(60);
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
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
