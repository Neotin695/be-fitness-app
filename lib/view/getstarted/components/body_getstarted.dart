import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/service/locatoin_service.dart';
import '../../auth/cubit/auth_cubit.dart';
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
          showErrorMessage(context, state).show();
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
                'Tell us more about you',
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text(isLastStep ? 'Upload My Data' : 'Continue'),
            ),
            cubit.currentStep == 0
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
          ],
        );
      },
    );
  }

  List<Step> fetchStep(GetstartedCubit cubit) {
    return [
      Step(
        isActive: cubit.currentStep >= 0,
        state: cubit.currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Basic Info'),
        content: Column(
          children: [
            CustomTextField(
              cn: cubit.userName,
              title: 'UserName',
              icon: Icons.person,
              inputType: TextInputType.name,
              fieldFor: FieldFor.name,
            ),
            CustomTextField(
              cn: cubit.age,
              title: 'Age',
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
        title: const Text('Additional Info'),
        content: Column(
          children: [
            CustomTextField(
              cn: cubit.height,
              title: 'Height',
              icon: Icons.height,
              inputType: TextInputType.number,
              fieldFor: FieldFor.height,
            ),
            CustomTextField(
              cn: cubit.weight,
              title: 'Weight',
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
                });
              },
              label: const Text('Locate Current Location'),
              icon: const Icon(Icons.my_location),
            )
          ],
        ),
      ),
      Step(
        state: cubit.currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 3,
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

  Row dropDownButton(GetstartedCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton<String>(
          value: cubit.genderSelected,
          items: ['male', 'female'].map<DropdownMenuItem<String>>((e) {
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
          items: ['beginner', 'intermediate', 'advanced']
              .map<DropdownMenuItem<String>>((e) {
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
