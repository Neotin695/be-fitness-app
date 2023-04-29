import 'dart:io';

import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              width: double.infinity,
              height: 35.h,
              child: InkWell(
                onTap: () async {
                  cubit.imagePath = await pickSingleImage(ImageSource.camera);
                },
                child: widget.traineeModel.profilePhoto.isNotEmpty
                    ? CircleAvatar(
                        radius: 50.sp,
                        foregroundImage:
                            FileImage(File(widget.traineeModel.profilePhoto)),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(365),
                        child: Image.asset(
                          MediaConst.person,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Name: ${widget.traineeModel.userName}'),
            ),
          ),
          const Divider(),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Email: ${widget.traineeModel.email}'),
            ),
          ),
          const Divider(),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Address: ${widget.traineeModel.address.country}'),
            ),
          ),
          const Divider(),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Age: ${widget.traineeModel.age}'),
            ),
          ),
          const Divider(),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Height: ${widget.traineeModel.height}CM'),
            ),
          ),
          const Divider(),
          Card(
            elevation: 3,
            child: ListTile(
              title: Text('Weight: ${widget.traineeModel.weight}KG'),
            ),
          ),
          const Divider(),
          ElevatedButton(onPressed: () {}, child: const Text('Edit Profile'))
        ],
      ),
    );
  }
}
