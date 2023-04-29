import 'dart:io';

import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/logic_constance.dart';

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
    return Column(
      children: [
        SizedBox(height: 7.h),
        Container(
          color: Colors.blue,
          width: double.infinity,
          height: 35.h,
          child: Center(
            child: InkWell(
              onTap: () async {
                cubit.imagePath = await pickSingleImage(ImageSource.camera);
              },
              child: widget.coachModel.profilePhoto.isNotEmpty
                  ? CircleAvatar(
                      radius: 50.sp,
                      foregroundImage:
                          FileImage(File(widget.coachModel.profilePhoto)),
                    )
                  : Image.asset(
                      MediaConst.person,
                      filterQuality: FilterQuality.high,
                    ),
            ),
          ),
        ),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Name: ${widget.coachModel.userName}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Email: ${widget.coachModel.email}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Address: ${widget.coachModel.address.country}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Certificate Id: ${widget.coachModel.certificateId}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('National Id: ${widget.coachModel.nationalId}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Birth of Date: ${widget.coachModel.birthDate}'),
          ),
        ),
        const Divider(),
        ElevatedButton(onPressed: () {}, child: const Text('Edit Profile'))
      ],
    );
  }
}
