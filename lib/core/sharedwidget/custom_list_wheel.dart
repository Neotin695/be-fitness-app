import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BeListWheel extends StatefulWidget {
  final List<Widget> list;
  final void Function(int) onSelectedChange;
  double? itemExtent;
  BeListWheel({
    this.itemExtent,
    super.key,
    required this.list,
    required this.onSelectedChange,
  });

  @override
  State<BeListWheel> createState() => _BeListWheelState();
}

class _BeListWheelState extends State<BeListWheel> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
        looping: true,
        itemExtent: widget.itemExtent??80,
        useMagnifier: true,
        magnification: 1,
        selectionOverlay: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.green, width: 3),
                    bottom: BorderSide(color: Colors.green, width: 3))),
          ),
        ),
        onSelectedItemChanged: widget.onSelectedChange,
        children: widget.list);
  }
}
