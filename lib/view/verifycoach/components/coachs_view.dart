import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/chat/screens/chat_room_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          .where('id',isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final coach = CoachModel.fromMap(doc.data());
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ChatRoomPage.routeName,
                      arguments: coach.id);
                },
                leading: const Icon(Icons.person),
                title: Text(coach.userName),
                subtitle:
                    Text(GenderService().convertEnumToString(coach.gender)),
              );
            }).toList(),
          );
        }
        return SvgPicture.asset(
          MediaConstance.empty,
          width: 30.w,
          height: 30.h,
        );
      },
    );
  }
}
