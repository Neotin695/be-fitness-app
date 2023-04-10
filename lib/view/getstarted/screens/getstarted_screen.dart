import 'package:be_fitness_app/view/getstarted/screens/create_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../verifycoach/screens/verify_coach_screen.dart';

class GetStartedScreen extends StatefulWidget {
  static const String routeName = 'getstarted';
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with RestorationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          SvgPicture.asset(
            MediaConstance.choose,
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

  @override
  // TODO: implement restorationId
  String? get restorationId => 'get_started';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
  }
}
