import 'package:be_fitness_app/view/verifycoach/components/stepper_widget.dart';
import 'package:be_fitness_app/view/verifycoach/screens/not_accepted_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';
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
    VerifyCoachCubit cubit = VerifyCoachCubit.get(context);
    return BlocListener<VerifyCoachCubit, VerifyCoachState>(
      listener: (context, state) {
        if (state is ImgUploading) {
          CoolAlert.show(context: context, type: CoolAlertType.loading);
        } else if (state is ImgUploadSucess) {
          Navigator.pop(context);
        } else if (state is RequestSentSucess) {
          Navigator.pushNamed(context, NotAcceptedScreen.routeName);
        } else if (state is ImgUploadFailure) {
          showErrorMessage(context, state);
        }
      },
      child: SafeArea(
        child: Form(
          key: cubit.key,
          child: Column(
            children: [
              SvgPicture.asset(MediaConstance.verify,
                  width: 25.w, height: 25.h),
              Text(
                AppConst.verifyCoachHeading,
                style: TextStyle(fontSize: 25.sp),
              ),
              Expanded(child: CustomStepperWidget(cubit: cubit))
            ],
          ),
        ),
      ),
    );
  }

  void showErrorMessage(BuildContext context, ImgUploadFailure state) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: AppConst.errorTxt,
      text: state.message,
      onCancelBtnTap: () => Navigator.pop(context),
    );
  }
}
