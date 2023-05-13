import 'package:be_fitness_app/view/getstarted/screens/create_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/sharedwidget/custom_circular_button.dart';
import '../../coach/screens/create_coach_page.dart';

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'TELL US WHO ARE YOU?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Coach for training trainees',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            CircularButton(
              hero: 'trainee',
              onPressed: () {
                Navigator.pushNamed(context, CreateProfilePage.routeName);
              },
              icon: SvgPicture.asset(
                MediaConst.trainee,
                width: 8.w,
                height: 8.h,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    BlendMode.srcIn),
              ),
              text: 'Trainee',
            ),
            CircularButton(
              hero: 'coach',
              onPressed: () {
                Navigator.pushNamed(context, CreateCoachPage.routeName);
              },
              icon: SvgPicture.asset(
                MediaConst.coach,
                width: 8.w,
                height: 8.h,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    BlendMode.srcIn),
              ),
              text: 'Coach',
            ),
          ],
        ),
      ),
    );
  }
}
