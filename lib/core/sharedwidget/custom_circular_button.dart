import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CircularButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final void Function()? onPressed;
  final String hero;
  Color? color;
  double? width;
  double? height;
  CircularButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.hero,
      this.color,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40.w,
      height: height ?? 30.h,
      child: FittedBox(
        child: FloatingActionButton.large(
          backgroundColor: color,
          heroTag: hero,
          onPressed: onPressed,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [icon, Text(text)],
            ),
          ),
        ),
      ),
    );
  }
}
