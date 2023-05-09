import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/coach/screens/details_coach_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/logic_constance.dart';

class CoachsView extends StatelessWidget {
  const CoachsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(LogicConst.users)
          .where('isCoach', isEqualTo: true)
          .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: SvgPicture.asset(
              MediaConst.empty,
              width: 30.w,
              height: 30.h,
            ));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final coach = CoachModel.fromMap(doc.data());
              return Container(
                margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 2.h),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, DetailsCoachPage.routeName,
                            arguments: coach);
                      },
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(coach.profilePhoto),
                        radius: 30,
                      ),
                      title: Row(
                        children: [
                          Text(
                            coach.userName,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(width: 3.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.3.h),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '4.5',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      subtitle: Text(
                          GenderService().convertEnumToString(coach.gender)),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  size: 35.sp));
        }
        return Center(
          child: SvgPicture.asset(
            MediaConst.empty,
            width: 30.w,
            height: 30.h,
          ),
        );
      },
    );
  }
}
