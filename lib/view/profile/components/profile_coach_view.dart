import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:be_fitness_app/view/profile/screens/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:image_picker/image_picker.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
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
                            NetworkImage(widget.coachModel.profilePhoto),
                      )
                    : Image.asset(
                        MediaConst.person,
                        filterQuality: FilterQuality.high,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 15.h,
            child: ratingWidget(),
          ),
          const Divider(),
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
              title: Text(
                  'Address: ${widget.coachModel.address.country}, ${widget.coachModel.address.locality}'),
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
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, UpdateProfilePage.routeName,
                    arguments: widget.coachModel);
              },
              child: const Text('Edit Profile'))
        ],
      ),
    );
  }

  Widget ratingWidget() {
    return Card(
      elevation: 3,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RatingStars(
              value: widget.coachModel.rating.ratingAverage,
              onValueChanged: (v) {},
              starBuilder: (index, color) => Icon(
                Icons.star,
                color: color,
                size: 30.sp,
              ),
              starCount: 5,
              starSize: 30.sp,
              valueLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 17.0),
              valueLabelRadius: 10,
              maxValue: 5,
              starSpacing: 2,
              maxValueVisibility: true,
              valueLabelVisibility: true,
              animationDuration: const Duration(milliseconds: 1000),
              valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: const Color(0xffe7e8ea),
              starColor: Colors.yellow,
            ),
            Text(
              ' ${widget.coachModel.subscribers.length}\n Subscribers',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
