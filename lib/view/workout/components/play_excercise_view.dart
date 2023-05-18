import 'package:be_fitness_app/core/service/enumservice/target_muscles.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';

class PlayExcerciseView extends StatefulWidget {
  final ExcerciseModel excercise;
  const PlayExcerciseView({super.key, required this.excercise});

  @override
  State<PlayExcerciseView> createState() => _PlayExcerciseViewState();
}

class _PlayExcerciseViewState extends State<PlayExcerciseView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          GifView.network(
            widget.excercise.gifUrl,
            fit: BoxFit.cover,
            width: 10.w,
            repeat: ImageRepeat.repeat,
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Text(
              widget.excercise.name,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Text(
              TargetMusclesService()
                  .convertEnumToString(widget.excercise.targetMuscles),
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
