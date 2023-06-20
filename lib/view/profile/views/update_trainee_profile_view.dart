import 'dart:io';

import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:be_fitness_app/view/profile/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';

class UpdateTraineeProfileView extends StatefulWidget {
  final TraineeModel trainee;
  const UpdateTraineeProfileView({super.key, required this.trainee});

  @override
  State<UpdateTraineeProfileView> createState() =>
      _UpdateTraineeProfileViewState();
}

class _UpdateTraineeProfileViewState extends State<UpdateTraineeProfileView>
    with PickMedia {
  late ProfileCubit cubit;
  @override
  void initState() {
    cubit = ProfileCubit.get(context);
    cubit.userName.text = widget.trainee.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 2.h,
                  ),
                  child: widget.trainee.profilePhoto.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(MediaConst.border))),
                          child: CircleAvatar(
                            radius: 35.sp,
                            backgroundImage: const AssetImage(
                                'assets/images/border_photo.png'),
                            foregroundImage:
                                NetworkImage(widget.trainee.profilePhoto),
                          ),
                        )
                      : cubit.imagePath.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(MediaConst.border))),
                              child: CircleAvatar(
                                radius: 35.sp,
                                foregroundImage:
                                    const AssetImage(MediaConst.person),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(MediaConst.border))),
                              child: CircleAvatar(
                                radius: 35.sp,
                                foregroundImage:
                                    FileImage(File(cubit.imagePath)),
                              ),
                            ),
                ),
              ),
              Positioned(
                left: 55.w,
                top: 12.h,
                child: IconButton(
                  onPressed: () async {
                    cubit.imagePath =
                        await pickSingleImage(ImageSource.gallery);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 25.sp,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: TextFormField(
              controller: cubit.userName,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your name';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                labelText: 'User Name',
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 7.h,
            child: ElevatedButton(
              onPressed: () async {
                if (cubit.imagePath.isEmpty) {
                  await cubit
                      .updateProfileWithoutImage()
                      .then((value) => Navigator.pop(context));
                } else {
                  await cubit
                      .updateProfile()
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text('Update'),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}
