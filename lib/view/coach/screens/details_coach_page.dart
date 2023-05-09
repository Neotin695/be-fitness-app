import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/details_coach_view.dart';

class DetailsCoachPage extends StatelessWidget {
  static const String routeName = '/reviewCoach';
  const DetailsCoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coach = ModalRoute.of(context)!.settings.arguments as CoachModel;
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => CoachCubit(),
        child: DetailsCoachView(coach: coach),
      ),
    );
  }
}
