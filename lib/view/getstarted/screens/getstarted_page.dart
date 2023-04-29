import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/view/getstarted/screens/create_profile_page.dart';
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

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppConst.appBarWelcome),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          SvgPicture.asset(
            MediaConst.choose,
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(height: 5.h),
          Center(
              child: Text(
            AppConst.getStartedHeading,
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
                  child: const Text(AppConst.confirmTxt)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, VerifyCoachScreen.routeName);
                },
                child: const Text(AppConst.cancelTxt),
              )
            ],
          )
        ],
      ),
    );
  }
}
