import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:be_fitness_app/view/verifycoach/screens/not_accepted_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/service/locatoin_service.dart';
import '../../getstarted/cubit/getstarted_cubit.dart';
import '../cubit/verifycoach_cubit.dart';
import 'custom_text_field_coach.dart';

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
                'Request Online Coaching',
                style: TextStyle(fontSize: 25.sp),
              ),
              Expanded(child: buildStepperWidget(cubit))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStepperWidget(VerifyCoachCubit cubit) {
    return Stepper(
      steps: fetchStep(cubit),
      currentStep: cubit.currentStep,
      onStepContinue: () => onContinue(cubit),
      onStepCancel: () {
        bool isFirstStep = cubit.currentStep == 0;
        if (!isFirstStep) {
          setState(() {
            cubit.currentStep -= 1;
          });
        }
      },
      controlsBuilder: (context, details) {
        bool isLastStep = cubit.currentStep == fetchStep(cubit).length - 1;
        return cubit.currentStep < 1 || cubit.currentStep == 6
            ? Center(
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(isLastStep ? 'Upload My Data' : 'Continue'),
                ),
              )
            : const SizedBox();
      },
    );
  }

  void onContinue(VerifyCoachCubit cubit) async {
    bool isLastStep = cubit.currentStep == fetchStep(cubit).length - 1;
    if (!isLastStep) {
      setState(() {
        cubit.currentStep++;
      });
    }
    //SmartDialog.showLoading();
    isLastStep ? await cubit.sentRequest() : null;
  }

  List<Step> fetchStep(VerifyCoachCubit cubit) {
    return [
      Step(
        isActive: cubit.currentStep >= 0,
        state: cubit.currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Basic Info'),
        content: Column(
          children: [
            CustomTextFieldCoach(
              cn: cubit.name,
              title: 'UserName',
              icon: Icons.person,
              inputType: TextInputType.name,
              fieldFor: FieldFor.name,
            ),
            CustomTextFieldCoach(
              cn: cubit.nationalId,
              title: 'National ID',
              icon: Icons.height,
              inputType: TextInputType.number,
              fieldFor: FieldFor.nationalId,
            ),
            CustomTextFieldCoach(
              cn: cubit.certificateId,
              title: 'Certificate ID',
              icon: Icons.line_weight,
              inputType: TextInputType.number,
              fieldFor: FieldFor.certificateId,
            ),
            dropDownButton(cubit),
          ],
        ),
      ),
      Step(
        isActive: cubit.currentStep >= 1,
        state: cubit.currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text('Personal Photo'),
        content: Center(
          child: ElevatedButton(
            onPressed: () async {
              cubit.request.personalImg = await cubit.pickPersonalImg();
              print(cubit.request.personalImg);
              if (cubit.request.personalImg.isNotEmpty) {
                onContinue(cubit);
              }
            },
            child: const Text('personal photo Doc'),
          ),
        ),
      ),
      Step(
        state: cubit.currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 2,
        title: const Text('Certificate Doc'),
        content: Center(
          child: ElevatedButton(
              onPressed: () async {
                cubit.request.certificateIdImg =
                    await cubit.pickDocument(context);
                print(cubit.request.certificateIdImg);
                if (cubit.request.certificateIdImg.isNotEmpty) {
                  onContinue(cubit);
                }
              },
              child: const Text('certificate Doc')),
        ),
      ),
      Step(
        state: cubit.currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 3,
        title: const Text('Front Id Card Doc'),
        content: Center(
          child: ElevatedButton(
              onPressed: () async {
                cubit.request.nationalIdFrontImg =
                    await cubit.pickDocument(context);
                print(cubit.request.nationalIdFrontImg);
                if (cubit.request.nationalIdFrontImg.isNotEmpty) {
                  onContinue(cubit);
                }
              },
              child: const Text('front id card Doc')),
        ),
      ),
      Step(
        state: cubit.currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 4,
        title: const Text('Back Id Card Doc'),
        content: Center(
            child: ElevatedButton(
                onPressed: () async {
                  cubit.request.nationalIdBakcImg =
                      await cubit.pickDocument(context);
                  print(cubit.request.nationalIdBakcImg);
                  if (cubit.request.nationalIdBakcImg.isNotEmpty) {
                    onContinue(cubit);
                  }
                },
                child: const Text('back id card Doc'))),
      ),
      Step(
        isActive: cubit.currentStep >= 5,
        state: cubit.currentStep > 5 ? StepState.complete : StepState.indexed,
        title: const Text('Your location'),
        content: Column(
          children: [
            Text(
                '${cubit.address.name}, ${cubit.address.country}, ${cubit.address.locality}, ${cubit.address.postalCode},'),
            ElevatedButton.icon(
              onPressed: () async {
                var tempAddress = await LocationService().getCurrentLocation();
                setState(() {
                  cubit.address = tempAddress;
                  onContinue(cubit);
                });
              },
              label: const Text('Locate Current Location'),
              icon: const Icon(Icons.my_location),
            )
          ],
        ),
      ),
      Step(
        state: cubit.currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 6,
        title: const Text('Complete'),
        content: const SizedBox(),
      ),
    ];
  }

  AwesomeDialog showErrorMessage(BuildContext context, UploadFailure state) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: state.message,
      btnCancelOnPress: () {},
    );
  }

  Widget dropDownButton(VerifyCoachCubit cubit) {
    return DropdownButton<String>(
      value: cubit.selectedGender,
      items: ['male', 'female'].map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          cubit.selectedGender = value!;
        });
      },
    );
  }
}
