import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ExcerciseView extends StatefulWidget {
  const ExcerciseView({super.key});

  @override
  State<ExcerciseView> createState() => _ExcerciseViewState();
}

class _ExcerciseViewState extends State<ExcerciseView> {
  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {},
      child: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                'Add Excercise',
                style: TextStyle(fontSize: 25.sp),
              ),
              adminTextField('Excercise Name', cubit.excerciseName),
              adminTextField('GIF Url', cubit.gifUrl),
              SizedBox(height: 3.h),
              TextButton(
                  child: Text(
                    'time:${cubit.selectedTime.inMinutes}:${cubit.selectedTime.inSeconds}',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  onPressed: () {
                    showDialogTimerPicker(context, cubit);
                  }),
              dropDown(cubit),
              ElevatedButton(
                  onPressed: () async {
                    await cubit.uploadExcercise();
                  },
                  child: const Text('upload'))
            ],
          ),
        ),
      ),
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
                  width: 90.w,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.ms,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        cubit.selectedTime = value;
                      });
                    },
                  ),
                ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton<String>(
            value: cubit.selectedBodyPart,
            items: [
              "back",
              "cardio",
              "chest",
              "lower arms",
              "lower legs",
              "neck",
              "shoulders",
              "upper arms",
              "upper legs",
              "waist"
            ]
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
            value: cubit.selectedTargetMuscles,
            items: [
              "abductors",
              "abs",
              "adductors",
              "biceps",
              "calves",
              "cardiovascular system",
              "delts",
              "forearms",
              "glutes",
              "hamstrings",
              "lats",
              "levator scapulae",
              "pectorals",
              "quads",
              "serratus anterior",
              "spine",
              "traps",
              "triceps",
              "upper back"
            ]
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
    );
  }

  Widget adminTextField(label, cn) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: TextFormField(
        controller: cn,
        decoration: InputDecoration(
          labelText: label,
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
