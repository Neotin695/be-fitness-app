import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class UpdateCoachProfileView extends StatelessWidget {
  final CoachModel coach;
  const UpdateCoachProfileView({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [],
    ));
  }
}
