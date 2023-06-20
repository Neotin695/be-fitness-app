import 'dart:ui';

import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';

import '../cubit/music_player_cubit.dart';

class MusicPlayerView extends StatefulWidget {
  final int index;
  final ExcerciseModel excercise;
  const MusicPlayerView(
      {super.key, required this.index, required this.excercise});

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  late MusicPlayerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MusicPlayerCubit.get(context);
    cubit
        .setAudioUrl(
            'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3')
        .then((value) {
      if (mounted) {
        setState(() {});
      }
    });

    cubit.player.positionStream.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    cubit.player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MediaConst.images[widget.index]),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black38,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(widget.excercise.name),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 10.h),
            Card(
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GifView.network(
                  widget.excercise.gifUrl,
                  width: 70.w,
                  height: 35.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              widget.excercise.name,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18.sp),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: SizedBox(
                child: Card(
                  color: Colors.transparent,
                  elevation: 1,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    '${cubit.player.position.inMinutes}:${cubit.player.position.inSeconds % 60}'),
                                Expanded(
                                  child: Slider.adaptive(
                                    onChanged: (value) async {
                                      await cubit.player.seek(
                                          Duration(seconds: value.toInt()));
                                      setState(() {});
                                    },
                                    value: cubit.player.position.inSeconds
                                        .toDouble(),
                                    max: cubit.audioDuration.inSeconds
                                        .toDouble(),
                                    min: 0,
                                  ),
                                ),
                                Text(
                                    '${cubit.audioDuration.inMinutes}:${cubit.audioDuration.inSeconds % 60}'),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'skip previous',
                                onPressed: () {},
                                child: const Icon(Icons.skip_previous),
                              ),
                              FloatingActionButton(
                                heroTag: 'play',
                                onPressed: () {
                                  if (cubit.player.playing) {
                                    cubit.player.pause();
                                  } else {
                                    cubit.player.play();
                                  }
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: Icon(cubit.player.playing
                                    ? Icons.pause
                                    : Icons.play_arrow),
                              ),
                              FloatingActionButton.small(
                                heroTag: 'skip next',
                                onPressed: () {},
                                child: const Icon(Icons.skip_next),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
