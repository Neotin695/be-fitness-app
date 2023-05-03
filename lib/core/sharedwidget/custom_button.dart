import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BeButton extends StatelessWidget {
  final double? width;
  final double? hegiht;
  final Color? color;
  final String? text;
  final Widget? icon;
  final double? radius;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  const BeButton({
    super.key,
    this.width,
    this.hegiht,
    this.color,
    this.text,
    this.icon,
    this.radius,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100,
      height: hegiht ?? 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: color,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? 'Button',
              style:
                  textStyle ?? TextStyle(color: Colors.black, fontSize: 17.sp),
            ),
            SizedBox(width: 3.w),
            icon ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
