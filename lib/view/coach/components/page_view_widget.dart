import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';
import '../../../core/service/locatoin_service.dart';
import '../../../core/sharedwidget/custom_circular_button.dart';
import '../cubit/coach_cubit.dart';
import 'custom_text_field_coach.dart';

class PageViewWidget extends StatefulWidget {
  final CoachCubit cubit;
  const PageViewWidget({super.key, required this.cubit});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;
    return PageView(
      controller: cubit.pageController,
      children: fetchStep(cubit),
      onPageChanged: (value) {},
    );
  }

  void onContinue(CoachCubit cubit) async {
    await cubit.sentRequest();
  }

  List<Widget> fetchStep(CoachCubit cubit) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            Text(
              'TELL US ABOUT YOURSELF!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'To give you a better experience we need to know your gender',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            CustomTextFieldCoach(
                cn: cubit.name,
                title: 'Name',
                inputType: TextInputType.name,
                fieldFor: FieldFor.name)
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            Text(
              'TELL US ABOUT YOURSELF!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'To give you a better experience we need to know your gender',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            CircularButton(
              hero: 'female',
              color: cubit.genderSelected == 'female'
                  ? null
                  : cubit.unselectedColor,
              onPressed: () {
                setState(() {
                  cubit.genderSelected = 'female';
                });
              },
              icon: const Icon(Icons.female),
              text: 'Female',
            ),
            CircularButton(
              hero: 'male',
              color:
                  cubit.genderSelected == 'male' ? null : cubit.unselectedColor,
              onPressed: () {
                setState(() {
                  cubit.genderSelected = 'male';
                });
              },
              icon: const Icon(Icons.male),
              text: 'Male',
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Text(
              'ChOOSE YOUR PERSONAL PHOTO!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'to check with national card id, please choose real photo',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: () async {
                cubit.request.personalImg = await cubit.pickSingleImg();

                cubit.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.camera),
              label: const Text(AppConst.takePersonalPhotoTxt),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Text(
              'ChOOSE YOUR TRAINER CERTIFICATE!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'to check if you true trainer, to make better safe for trainee',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
                onPressed: () async {
                  cubit.request.certificateIdImg =
                      await cubit.pickSingleDoc(context);

                  cubit.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.document_scanner),
                label: const Text(AppConst.certificateDocTxt)),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Text(
              'ChOOSE YOUR NATIONAL CARD ID!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'to check your information is true, to make better safe for trainee',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: () async {
                cubit.request.nationalIdFrontImg =
                    await cubit.pickSingleDoc(context);

                cubit.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.document_scanner),
              label: const Text(AppConst.frontCardIdDocTxt),
            ),
            SizedBox(height: 3.h),
            ElevatedButton.icon(
              onPressed: () async {
                cubit.request.nationalIdBakcImg =
                    await cubit.pickSingleDoc(context);

                cubit.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.document_scanner),
              label: const Text(AppConst.backCardIdDocTxt),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Text(
              'LOCATE YOUR LOCATION!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'until we introduce you to trainees near you',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
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
      const SizedBox(),
    ];
  }

  Row dateAndGender(CoachCubit cubit) {
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

  void pickDate(CoachCubit cubit) {
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

  Widget dropDownButton(CoachCubit cubit) {
    return DropdownButton<String>(
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
    );
  }
}
