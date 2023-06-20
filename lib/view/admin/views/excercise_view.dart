import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/sharedwidget/custom_list_wheel.dart';
import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ExcerciseAdminView extends StatefulWidget {
  const ExcerciseAdminView({super.key});

  @override
  State<ExcerciseAdminView> createState() => _ExcerciseAdminViewState();
}

class _ExcerciseAdminViewState extends State<ExcerciseAdminView> {
  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is UploadedExcercise) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'excercise successfully',
              title: 'successfully');
        } else if (state is FailureState) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: state.message,
              title: 'Error');
        }
      },
      child: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              SizedBox(height: 3.h),
              SvgPicture.asset(
                MediaConst.workout,
                width: 30.w,
                height: 30.h,
              ),
              adminTextField('Excercise Name', cubit.excerciseName),
              adminTextField('GIF Url', cubit.gifUrl),
              SizedBox(height: 3.h),
              dropDown(cubit),
              buttons(cubit, context),
            ],
          ),
        ),
      ),
    );
  }

  Row buttons(AdminCubit cubit, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cubit.isSelected()
            ? ElevatedButton.icon(
                onPressed: () async {
                  await cubit.uploadExcercise();
                },
                label: Text(
                  'Upload Excercise',
                  style: TextStyle(fontSize: 14.sp),
                ),
                icon: const Icon(Icons.upload),
              )
            : const SizedBox(),
        SizedBox(width: 3.w),
        ElevatedButton.icon(
            icon: const Icon(Icons.alarm),
            label: Text(
              'Select Duration',
              style: TextStyle(fontSize: 14.sp),
            ),
            onPressed: () {
              showDialogTimerPicker(context, cubit);
            }),
      ],
    );
  }

  Future<dynamic> showDialogTimerPicker(
      BuildContext context, AdminCubit cubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          width: 30.w,
          height: 80.h,
          child: SimpleDialog(
            title: const Center(child: Text('Select a Duration')),
            children: [
              Center(
                child: SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: BeListWheel(
                            itemExtent: 41,
                            list: List.generate(
                                100,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('$index'),
                                    )),
                            onSelectedChange: (v) {
                              cubit.x = v;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: BeListWheel(
                            itemExtent: 41,
                            list: List.generate(
                                100,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('$index'),
                                    )),
                            onSelectedChange: (v) {
                              cubit.y = v;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Submit')),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget dropDown(AdminCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
              hint: Text(cubit.selectedBodyPart),
              items: LogicConst.bodyPart
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  cubit.selectedBodyPart = value!;
                });
              }),
          DropdownButton<String>(
              hint: Text(cubit.selectedTargetMuscles),
              items: LogicConst.targetMuscles
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  cubit.selectedTargetMuscles = value!;
                });
              }),
        ],
      ),
    );
  }

  Widget adminTextField(label, cn) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: TextFormField(
        controller: cn,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: label,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'this field is required';
          }
          return null;
        },
      ),
    );
  }
}
