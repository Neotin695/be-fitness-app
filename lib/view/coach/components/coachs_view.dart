import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/coach/screens/review_coach_page.dart';
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
                margin: EdgeInsets.symmetric(vertical: 2.h),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, ReviewCoachPage.routeName,
                          arguments: coach);
                    },
                    leading: Image.network(
                      coach.profilePhoto,
                      width: 25.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                    ),
                    title: Text(coach.userName),
                    subtitle:
                        Text(GenderService().convertEnumToString(coach.gender)),
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
