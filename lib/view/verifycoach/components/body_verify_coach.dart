import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../cubit/verifycoach_cubit.dart';

class BodyVerifyCoach extends StatefulWidget {
  const BodyVerifyCoach({super.key});

  @override
  State<BodyVerifyCoach> createState() => _BodyVerifyCoachState();
}

class _BodyVerifyCoachState extends State<BodyVerifyCoach> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCoachCubit, VerifyCoachState>(
      listener: (context, state) {},
      child: Column(
        children: [
          SvgPicture.asset(MediaConstance.verify, width: 25.w, height: 25.h),
        ],
      ),
    );
  }
}
