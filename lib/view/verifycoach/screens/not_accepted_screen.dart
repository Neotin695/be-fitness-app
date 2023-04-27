import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/home/screens/home_layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';
import '../cubit/verifycoach_cubit.dart';

class NotAcceptedScreen extends StatefulWidget {
  static const String routeName = 'not accepted';
  const NotAcceptedScreen({super.key});

  @override
  State<NotAcceptedScreen> createState() => _NotAcceptedScreenState();
}

class _NotAcceptedScreenState extends State<NotAcceptedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCoachCubit(),
      child: const BodyNotAccepted(),
    );
  }
}

class BodyNotAccepted extends StatelessWidget {
  const BodyNotAccepted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    VerifyCoachCubit cubit = VerifyCoachCubit.get(context);
    cubit.checkCoachState();
    return BlocBuilder<VerifyCoachCubit, VerifyCoachState>(
      builder: (context, state) {
        if (state is AceeptedState) {
          return const HomeLayoutPage();
        } else if (state is RejectState) {
          return const DecisionsTree();
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  MediaConst.waiting,
                  width: 30.w,
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  child: Text(AppConst.notAceeptedHeading,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.sp)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
