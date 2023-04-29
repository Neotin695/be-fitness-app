import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DecisionProfile extends StatelessWidget {
  const DecisionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return FutureBuilder<DocumentSnapshot>(
      future:
          cubit.store.collection(LogicConst.users).doc(cubit.auth.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return cubit.checkUserType(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}
