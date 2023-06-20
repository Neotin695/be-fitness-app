import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/appconstance/logic_constance.dart';
import '../views/display_reviews_view.dart';

class DisplayReviewsPage extends StatelessWidget {
  static const String routeName = '/displayReviews';
  const DisplayReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CoachModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            customPop(args, context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text('Read All Reviews'),
      ),
      body: BlocProvider(
        create: (_) => CoachCubit(),
        child: DisplayReviewsView(
          coach: args,
        ),
      ),
    );
  }

  void customPop(CoachModel args, BuildContext context) {
    FirebaseFirestore.instance
        .collection(LogicConst.users)
        .doc(args.id)
        .get()
        .then((value) {
      var coach = CoachModel.fromMap(value.data() as Map<String, dynamic>);
      Navigator.pop<CoachModel>(context, coach);
    });
  }
}
