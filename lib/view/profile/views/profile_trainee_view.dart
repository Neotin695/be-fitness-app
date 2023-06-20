import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:be_fitness_app/view/profile/page/update_profile_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 2.h,
            ),
            child: widget.traineeModel.profilePhoto.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(MediaConst.border))),
                    child: CircleAvatar(
                      radius: 35.sp,
                      backgroundImage:
                          const AssetImage('assets/images/border_photo.png'),
                      foregroundImage:
                          NetworkImage(widget.traineeModel.profilePhoto),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(MediaConst.border))),
                    child: CircleAvatar(
                      radius: 35.sp,
                      foregroundImage: const AssetImage(MediaConst.person),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              widget.traineeModel.userName,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 25.sp),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              'Edit Profile',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 17.sp),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, UpdateProfilePage.routeName,
                  arguments: widget.traineeModel);
            },
          ),
          const Divider(),
          ListTile(
            title: Text('Privacy Policy',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 17.sp)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Text('Settings',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 17.sp)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.emailVerified != true,
            child: ListTile(
              title: Text('Verify your email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 17.sp)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                String message =
                    'we send verify link to your email,\n please check your inbox';
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.loading,
                    text: 'please wait we send verification link');
                await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification()
                    .then((value) {
                  Navigator.pop(context);
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      text: message,
                      closeOnConfirmBtnTap: false,
                      onConfirmBtnTap: () async {
                        FirebaseAuth.instance.currentUser!.reload();
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          Navigator.pop(context);
                        }
                      });
                });
              },
            ),
          ),
          Visibility(
              visible: !FirebaseAuth.instance.currentUser!.emailVerified,
              child: const Divider()),
          const Spacer(),
          const Divider(),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, DecisionsTree.routeName));
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
