import 'package:be_fitness_app/view/coach/components/page_view_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';
import '../../../core/appconstance/media_constance.dart';
import '../cubit/coach_cubit.dart';
import '../screens/not_accepted_screen.dart';

class CreateCoachView extends StatefulWidget {
  const CreateCoachView({super.key});

  @override
  State<CreateCoachView> createState() => _CreateCoachViewState();
}

class _CreateCoachViewState extends State<CreateCoachView> {
  @override
  Widget build(BuildContext context) {
    CoachCubit cubit = CoachCubit.get(context);
    return BlocListener<CoachCubit, CoachState>(
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
              Expanded(child: PageViewWidget(cubit: cubit)),
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
