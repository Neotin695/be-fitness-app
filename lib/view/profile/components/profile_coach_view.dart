import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileCoachView extends StatefulWidget {
  final CoachModel coachModel;
  const ProfileCoachView({super.key, required this.coachModel});

  @override
  State<ProfileCoachView> createState() => _ProfileCoachViewState();
}

class _ProfileCoachViewState extends State<ProfileCoachView> with PickMedia {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 2.h,
                ),
                child: widget.coachModel.profilePhoto.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(MediaConst.border))),
                        child: CircleAvatar(
                          radius: 35.sp,
                          foregroundImage:
                              NetworkImage(widget.coachModel.profilePhoto),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(MediaConst.border))),
                        child: CircleAvatar(
                          radius: 35.sp,
                          backgroundImage: const AssetImage(MediaConst.border),
                          foregroundImage: const AssetImage(MediaConst.person),
                        ),
                      ),
              ),
              Container(
                height: 20.h,
                width: 0.2.w,
                margin: EdgeInsets.only(top: 8.h, left: 15.w),
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.coachModel.averageRate} \n Total Rate',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            ],
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
