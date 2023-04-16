import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../core/appconstance/app_constance.dart';
import '../../../core/service/locatoin_service.dart';
import '../cubit/verifycoach_cubit.dart';
import 'custom_text_field_coach.dart';

class CustomStepperWidget extends StatefulWidget {
  final VerifyCoachCubit cubit;
  const CustomStepperWidget({super.key, required this.cubit});

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;
    return Stepper(
      steps: fetchStep(widget.cubit),
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
                  child: Text(
                      isLastStep ? AppConst.uploadTxt : AppConst.continueTxt),
                ),
              )
            : const SizedBox();
      },
    );
  }

  void onContinue(VerifyCoachCubit cubit) async {
    bool isLastStep = cubit.currentStep == fetchStep(cubit).length - 1;
    if (cubit.currentStep == 0 && !cubit.key.currentState!.validate()) {
      return;
    }
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
        title: const Text(AppConst.basicInfoTxt),
        content: Column(
          children: [
            CustomTextFieldCoach(
              cn: cubit.name,
              title: AppConst.userNameTxt,
              icon: Icons.person,
              inputType: TextInputType.name,
              fieldFor: FieldFor.name,
            ),
            CustomTextFieldCoach(
              cn: cubit.nationalId,
              title: AppConst.nationalIdTxt,
              icon: Icons.height,
              inputType: TextInputType.number,
              fieldFor: FieldFor.nationalId,
            ),
            CustomTextFieldCoach(
              cn: cubit.certificateId,
              title: AppConst.certificateIdTxt,
              icon: Icons.line_weight,
              inputType: TextInputType.number,
              fieldFor: FieldFor.certificateId,
            ),
            dateAndGender(cubit),
          ],
        ),
      ),
      Step(
        isActive: cubit.currentStep >= 1,
        state: cubit.currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text(AppConst.personalPhotoTxt),
        content: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              cubit.request.personalImg = await cubit.pickPersonalImg();

              if (cubit.request.personalImg.isNotEmpty) {
                onContinue(cubit);
              }
            },
            icon: const Icon(Icons.camera),
            label: const Text(AppConst.takePersonalPhotoTxt),
          ),
        ),
      ),
      Step(
        state: cubit.currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 2,
        title: const Text(AppConst.certificateDocTxt),
        content: Center(
          child: ElevatedButton.icon(
              onPressed: () async {
                cubit.request.certificateIdImg =
                    await cubit.pickDocument(context);

                if (cubit.request.certificateIdImg.isNotEmpty) {
                  onContinue(cubit);
                }
              },
              icon: const Icon(Icons.document_scanner),
              label: const Text(AppConst.certificateDocTxt)),
        ),
      ),
      Step(
        state: cubit.currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 3,
        title: const Text(AppConst.frontIdCardDocTxt),
        content: Center(
          child: ElevatedButton.icon(
              onPressed: () async {
                cubit.request.nationalIdFrontImg =
                    await cubit.pickDocument(context);

                if (cubit.request.nationalIdFrontImg.isNotEmpty) {
                  onContinue(cubit);
                }
              },
              icon: const Icon(Icons.document_scanner),
              label: const Text(AppConst.frontIdCardDocTxt)),
        ),
      ),
      Step(
        state: cubit.currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 4,
        title: const Text(AppConst.backIdCardDocTxt),
        content: Center(
            child: ElevatedButton.icon(
                onPressed: () async {
                  cubit.request.nationalIdBakcImg =
                      await cubit.pickDocument(context);

                  if (cubit.request.nationalIdBakcImg.isNotEmpty) {
                    onContinue(cubit);
                  }
                },
                icon: const Icon(Icons.document_scanner),
                label: const Text(AppConst.backIdCardDocTxt))),
      ),
      Step(
        isActive: cubit.currentStep >= 5,
        state: cubit.currentStep > 5 ? StepState.complete : StepState.indexed,
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
                  onContinue(cubit);
                });
              },
              label: const Text(AppConst.locateLocationTxt),
              icon: const Icon(Icons.my_location),
            )
          ],
        ),
      ),
      Step(
        state: cubit.currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: cubit.currentStep >= 6,
        title: const Text(AppConst.completeTxt),
        content: const SizedBox(),
      ),
    ];
  }

  Row dateAndGender(VerifyCoachCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            pickDate(cubit);
          },
          child: const Text(
            'show date time picker',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        dropDownButton(cubit),
      ],
    );
  }

  void pickDate(VerifyCoachCubit cubit) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1970),
      maxTime: DateTime(2005, 12, 31),
      onChanged: (date) {},
      onConfirm: (date) {
        setState(() {
          cubit.birthDate = date;
        });
      },
      currentTime: DateTime.now(),
    );
  }

  Widget dropDownButton(VerifyCoachCubit cubit) {
    return DropdownButton<String>(
      value: cubit.selectedGender,
      items: [AppConst.maleTxt, AppConst.femaleTxt]
          .map<DropdownMenuItem<String>>((e) {
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
