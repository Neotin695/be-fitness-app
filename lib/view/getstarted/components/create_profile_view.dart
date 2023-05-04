import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/core/sharedwidget/custom_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/sharedwidget/custom_circular_button.dart';
import '../../../core/sharedwidget/custom_list_wheel.dart';
import '../../home/screens/home_layout_page.dart';
import '../cubit/getstarted_cubit.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({
    super.key,
  });

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> with PickMedia {
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
            HomeLayoutPage.routeName,
          );
        }
      },
      child: SafeArea(
        child: Form(
          key: cubit.key,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: cubit.controller,
                  children: fetchWidgets(cubit),
                  onPageChanged: (index) {
                    setState(() {
                      cubit.index = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: cubit.index != 0,
                      child: FloatingActionButton(
                        onPressed: () {
                          cubit.controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        backgroundColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    BeButton(
                      onPressed: () async {
                        if (cubit.index == fetchWidgets(cubit).length - 1) {
                          print('hello');
                        } else {
                          cubit.controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      text: 'Next',
                      color: Theme.of(context).colorScheme.primaryContainer,
                      radius: 30,
                      width: 40.w,
                      hegiht: 10.h,
                      icon: SvgPicture.asset(
                        MediaConst.arrow,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onPrimaryContainer,
                            BlendMode.srcIn),
                      ),
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> fetchWidgets(GetstartedCubit cubit) {
    return [
      Center(
        child: SingleChildScrollView(
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
              SizedBox(height: 20.h),
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
                color: cubit.genderSelected == 'male'
                    ? null
                    : cubit.unselectedColor,
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
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              'HOW OLD ARE YOU?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'This helps us create your personalized plan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BeListWheel(
                list: cubit.ages.map((e) {
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Text(
                        '$e',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }).toList(),
                onSelectedChange: (index) {
                  setState(() {
                    cubit.age = cubit.ages[index] + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              'WHAT`S YOUR WEIGHT?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'You can always change this later',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BeListWheel(
                list: cubit.weights.map((e) {
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Text(
                        '$e KG',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }).toList(),
                onSelectedChange: (index) {
                  setState(() {
                    cubit.weight = cubit.weights[index];
                  });
                },
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              'WHAT`S YOUR HEIGHT?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'This helps us create your personalized plan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BeListWheel(
                list: cubit.heights.getRange(130, 201).map((e) {
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Text(
                        '$e CM',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }).toList(),
                onSelectedChange: (index) {
                  setState(() {
                    cubit.height = cubit.heights[index];
                  });
                },
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              'YOUR REGULAR PHYSICAL ACTIVITY LEVEL?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 3.h),
            Text(
              'This helps us create your personalized plan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BeListWheel(
                list: cubit.levels.map((e) {
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }).toList(),
                onSelectedChange: (index) {
                  setState(() {
                    cubit.levelSelected = cubit.levels[index];
                  });
                },
              ),
            ),
          ],
        ),
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
}
