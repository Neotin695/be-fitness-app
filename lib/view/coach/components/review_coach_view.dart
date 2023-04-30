
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/chat/screens/chat_room_page.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';

// ignore: must_be_immutable
class ReviewCoachView extends StatefulWidget {
  CoachModel coach;
  ReviewCoachView({super.key, required this.coach});

  @override
  State<ReviewCoachView> createState() => _ReviewCoachViewState();
}

class _ReviewCoachViewState extends State<ReviewCoachView> {
  @override
  Widget build(BuildContext context) {
    final cubit = CoachCubit.get(context);
    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          height: 35.h,
          child: Center(
            child: widget.coach.profilePhoto.isNotEmpty
                ? CircleAvatar(
                    radius: 50.sp,
                    foregroundImage: NetworkImage(widget.coach.profilePhoto),
                  )
                : Image.asset(
                    MediaConst.person,
                    filterQuality: FilterQuality.high,
                  ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          height: 15.h,
          child: ratingWidget(cubit),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text('Name: ${widget.coach.userName}'),
          ),
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text(
                'Address: ${widget.coach.address.country}, ${widget.coach.address.locality}'),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (isSubscribe(cubit)) {
                    var tempCoach = await cubit.unSubscribe(widget.coach);
                    setState(() {
                      widget.coach = tempCoach;
                    });
                  } else {
                    var tempCoach = await cubit.subscribe(widget.coach);
                    setState(() {
                      widget.coach = tempCoach;
                    });
                  }
                },
                child: Text(isSubscribe(cubit) ? 'UnSubcribe' : 'Subcribe')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ChatRoomPage.routeName,
                      arguments: widget.coach.id);
                },
                child: const Text('message'))
          ],
        )
      ],
    );
  }

  bool isSubscribe(CoachCubit cubit) =>
      widget.coach.subscribers.contains(cubit.auth.uid);

  Widget ratingWidget(CoachCubit cubit) {
    return Card(
      elevation: 3,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RatingStars(
              value: widget.coach.rating.ratingAverage,
              onValueChanged: (v) async {
                final tempCoach = await cubit.rate(v, widget.coach);
                setState(() {
                  widget.coach = tempCoach;
                });
              },
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
              ' ${widget.coach.subscribers.length}\n Subscribers',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
