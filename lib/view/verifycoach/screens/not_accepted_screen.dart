import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/view/home/screens/home_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';

class NotAcceptedScreen extends StatelessWidget {
  static const String routeName = 'not accepted';
  const NotAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(LogicConst.tempUser)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String status =
                (snapshot.data!.data() as Map<String, dynamic>)[LogicConst.status];
            if (status == LogicConst.authenticate) {
              Navigator.pushNamed(context, HomeLayoutScreen.routeName);
            }
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      MediaConstance.waiting,
                      width: 30.w,
                      height: 30.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      child: Text(
                          AppConst.notAceeptedHeading,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.sp)),
                    )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
