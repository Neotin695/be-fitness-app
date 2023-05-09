import 'dart:io';

import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:be_fitness_app/view/profile/screens/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';

class ProfileTraineeView extends StatefulWidget {
  final TraineeModel traineeModel;
  const ProfileTraineeView({super.key, required this.traineeModel});

  @override
  State<ProfileTraineeView> createState() => _ProfileTraineeViewState();
}

class _ProfileTraineeViewState extends State<ProfileTraineeView>
    with PickMedia {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 2.h,
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  MediaConst.border,
                  width: 20.w,
                  height: 20.h,
                ),
                Positioned(
                  left: 3.w,
                  top: 2.2.h,
                  child: widget.traineeModel.profilePhoto.isNotEmpty
                      ? CircleAvatar(
                          radius: 50.sp,
                          backgroundImage: const AssetImage(
                              'assets/images/border_photo.png'),
                          foregroundImage:
                              FileImage(File(widget.traineeModel.profilePhoto)),
                        )
                      : CircleAvatar(
                          radius: 40.sp,
                          foregroundImage: const AssetImage(MediaConst.person),
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              cubit.auth.displayName!.split(' ').join('\n'),
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 25.sp),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          const Spacer(),
          const Divider(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, UpdateProfilePage.routeName,
                  arguments: widget.traineeModel);
            },
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
