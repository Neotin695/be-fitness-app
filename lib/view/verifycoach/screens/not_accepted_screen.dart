import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class NotAcceptedScreen extends StatelessWidget {
  static const String routeName = 'not accepted';
  const NotAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              MediaConstance.waiting,
              width: 30.w,
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Text(
                  'your request under review please wait, we notify you when done',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.sp)),
            )
          ],
        ),
      ),
    );
  }
}
