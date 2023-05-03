import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OpenPainter extends CustomPainter {
  final double width;
  final double height;

  OpenPainter({required this.width, required this.height});
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color.fromRGBO(28, 28, 30, 1)
      ..style = PaintingStyle.fill;

    //a rectangle
    canvas.drawRect(Offset(width, height) & Size(200.w, 20.h), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

Widget rectangleDig({required double width, required double height}) {
  return RotationTransition(
    turns: const AlwaysStoppedAnimation(-10 / 360),
    child: CustomPaint(painter: OpenPainter(width: width, height: height)),
  );
}
