import 'package:be_fitness_app/view/getstarted/screens/create_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../verifycoach/screens/verify_coach_screen.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = 'getstarted';
  const GetStartedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          SvgPicture.asset(
            'assets/icons/choose.svg',
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(height: 5.h),
          Center(
              child: Text(
            'How are you?',
            style: TextStyle(fontSize: 25.sp),
          )),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CreateProfileScreen.routeName);
                  },
                  child: const Text('Trainee')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, VerifyCoachScreen.routeName);
                  },
                  child: const Text('Coach'))
            ],
          )
        ],
      ),
    );
  }
}
