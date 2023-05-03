import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/sharedwidget/custom_paint.dart';
import 'package:be_fitness_app/main.dart';
import 'package:be_fitness_app/view/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/sharedwidget/custom_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingCubit.get(context);
    return PageView(
      onPageChanged: (value) => setState(() {
        cubit.onPageChange(value);
      }),
      children: cubit.listData().map<Widget>((data) {
        return Column(
          children: [
            Image.asset(data.image,
                width: double.infinity, fit: BoxFit.cover, height: 80.h),
            rectangleDig(width: -100.w, height: -12.h),
            Text(
              data.title,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.h),
            Visibility(
              visible: cubit.listData().length - 1 == cubit.index,
              child: BeButton(
                onPressed: () async {
                  await pref!.setBool('first', false).then((value) {
                    Navigator.pushReplacementNamed(
                        context, DecisionsTree.routeName);
                  });
                },
                text: 'Start Now',
                icon: SvgPicture.asset(MediaConst.arrow),
                color: const Color(0xFFD0FD3E),
                radius: 30,
                width: 80.w,
                hegiht: 10.h,
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
