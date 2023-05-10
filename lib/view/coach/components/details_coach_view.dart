import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/chat/screens/chat_room_page.dart';
import 'package:be_fitness_app/view/coach/components/review_item_view.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:be_fitness_app/view/coach/screens/display_reviews_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/logic_constance.dart';
import '../../../core/appconstance/media_constance.dart';
import '../../../models/review_model.dart';

// ignore: must_be_immutable
class DetailsCoachView extends StatefulWidget {
  CoachModel coach;
  DetailsCoachView({super.key, required this.coach});

  @override
  State<DetailsCoachView> createState() => _DetailsCoachViewState();
}

class _DetailsCoachViewState extends State<DetailsCoachView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CoachCubit.get(context);
    return StreamBuilder<QuerySnapshot>(
        stream: cubit.store
            .collection(LogicConst.users)
            .doc(widget.coach.id)
            .collection(LogicConst.reviews)
            .snapshots(),
        builder: (context, snapshot) {
          List<ReviewModel> reviews = [];

          if (snapshot.hasData) {
            reviews = List.from(snapshot.data!.docs.map((doc) =>
                ReviewModel.fromMap(doc.data() as Map<String, dynamic>)));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: Center(
                    child: widget.coach.profilePhoto.isNotEmpty
                        ? Image.network(
                            widget.coach.profilePhoto,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Image.asset(
                            MediaConst.person,
                            filterQuality: FilterQuality.high,
                          ),
                  ),
                ),
                SizedBox(height: 2.h),
                ListTile(
                  title: Text(
                    widget.coach.userName,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  subtitle: Text(
                    GenderService().convertEnumToString(widget.coach.gender),
                    style: TextStyle(
                        fontSize: 15.sp,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  trailing: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, ChatRoomPage.routeName,
                          arguments: widget.coach.id);
                    },
                    child: const Icon(Icons.message),
                  ),
                ),
                SizedBox(height: 5.h),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${6}\n Experience',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          '${widget.coach.subscribers.length}\n Active Clients',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Text(
                          'Reviews',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 0.7.h),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.coach.averageRate.toString(),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            widget.coach = ((await Navigator.pushNamed(
                                    context, DisplayReviewsPage.routeName,
                                    arguments: widget.coach)) as CoachModel?) ??
                                widget.coach;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            'Read All Reviews',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: SizedBox(
                    height: 25.h,
                    child: ListView(
                      children: reviews.map<Widget>((review) {
                        return ReviewItem(
                          review: review,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
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
                    child: Text(isSubscribe(cubit) ? 'UnSubcribe' : 'Subcribe'),
                  ),
                ),
              ],
            ),
          );
        });
  }

  bool isSubscribe(CoachCubit cubit) =>
      widget.coach.subscribers.contains(cubit.auth.uid);

  /*  Widget ratingWidget(CoachCubit cubit) {
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
  } */
}
