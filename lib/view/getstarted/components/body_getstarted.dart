import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/service/locatoin_service.dart';
import '../../home/screens/home_layout.dart';
import '../cubit/getstarted_cubit.dart';
import 'custom_text_field.dart';

class BodyStarted extends StatefulWidget {
  const BodyStarted({
    super.key,
  });

  @override
  State<BodyStarted> createState() => _BodyStartedState();
}

class _BodyStartedState extends State<BodyStarted> {
  @override
  Widget build(BuildContext context) {
    GetstartedCubit cubit = GetstartedCubit.get(context);
    return BlocListener<GetstartedCubit, GetstartedState>(
      listener: (context, state) {
        if (state is UploadFailure) {
          showErrorMessage(context, state);
        } else if (state is UploadLoading) {
          CoolAlert.show(context: context, type: CoolAlertType.loading);
        } else if (state is UploadSucess) {
          cubit.resetValues();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            HomeLayoutScreen.routeName,
          );
        }
      },
      child: SafeArea(
        child: Form(
          key: cubit.key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              SvgPicture.asset(
                MediaConstance.account,
                width: 15.w,
                height: 15.h,
              ),
              SizedBox(height: 2.h),
              Text(
                AppConst.createProfileHeading,
                style: TextStyle(fontSize: 24.sp),
              ),
              Expanded(child: buildStepperWidget(cubit)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStepperWidget(GetstartedCubit cubit) {
    return Stepper(
      steps: fetchStep(cubit),
      currentStep: cubit.currentStep,
      onStepContinue: () {
        bool isLastStep = cubit.currentStep == fetchStep(cubit).length - 1;
        if (isLastStep) {
          cubit.uploadData();
        } else {
          setState(() {
            cubit.currentStep++;
          });
        }
      },
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
        return ElevatedButton(
          onPressed: details.onStepContinue,
          child: Text(isLastStep ? AppConst.uploadTxt : AppConst.continueTxt),
        );
      },
    );
  }

  List<Step> fetchStep(GetstartedCubit cubit) {
    return [
      Step(
        isActive: cubit.currentStep >= 0,
        state: cubit.currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text(AppConst.basicInfoTxt),
        content: Column(
          children: [
            CustomTextField(
              cn: cubit.userName,
              title: AppConst.userNameTxt,
              icon: Icons.person,
              inputType: TextInputType.name,
              fieldFor: FieldFor.name,
            ),
            CustomTextField(
              cn: cubit.age,
              title: AppConst.ageTxt,
              icon: Icons.person_2_outlined,
              inputType: TextInputType.number,
              fieldFor: FieldFor.age,
            ),
          ],
        ),
      ),
      Step(
        isActive: cubit.currentStep >= 1,
        state: cubit.currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text(AppConst.additionalInfoTxt),
        content: Column(
          children: [
            CustomTextField(
              cn: cubit.height,
              title: AppConst.heightTxt,
              icon: Icons.height,
              inputType: TextInputType.number,
              fieldFor: FieldFor.height,
            ),
            CustomTextField(
              cn: cubit.weight,
              title: AppConst.weightTxt,
              icon: Icons.line_weight,
              inputType: TextInputType.number,
              fieldFor: FieldFor.weight,
            ),
            dropDownButton(cubit),
          ],
        ),
      ),
      Step(
        isActive: cubit.currentStep >= 2,
        state: cubit.currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Text(AppConst.locationTxt),
        content: Column(
          children: [
            Text(
                '${cubit.address.name}, ${cubit.address.country}, ${cubit.address.locality}, ${cubit.address.postalCode},'),
            ElevatedButton.icon(
              onPressed: () async {
                var tempAddress = await LocationService().getCurrentLocation();
                setState(() {
                  cubit.address = tempAddress;
                });
              },
              label: const Text(AppConst.locateLocationTxt),
              icon: const Icon(Icons.my_location),
            )
          ],
        ),
      ),
      Step(
        state: cubit.currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 3,
        title: const Text(AppConst.completeTxt),
        content: const SizedBox(),
      ),
    ];
  }

  void showErrorMessage(BuildContext context, UploadFailure state) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: AppConst.errorTxt,
      text: state.message,
      onCancelBtnTap: () => Navigator.pop(context),
    );
  }

  Row dropDownButton(GetstartedCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton<String>(
          value: cubit.genderSelected,
          items: [AppConst.maleTxt, AppConst.femaleTxt]
              .map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cubit.genderSelected = value!;
            });
          },
        ),
        DropdownButton<String>(
          value: cubit.levelSelected,
          items: [
            AppConst.beginnerTxt,
            AppConst.intermediateTxt,
            AppConst.advancedTxt
          ].map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cubit.levelSelected = value!;
            });
          },
        ),
      ],
    );
  }
}
