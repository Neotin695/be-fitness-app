import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/models/trainee_model.dart';

import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/update_coach_profile_view.dart';
import '../views/update_trainee_profile_view.dart';

class UpdateProfilePage extends StatelessWidget {
  static const String routeName = '/updatprofile';
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
      body: BlocProvider(
        create: (_) => ProfileCubit(),
        child: model is CoachModel
            ? UpdateCoachProfileView(coach: model)
            : UpdateTraineeProfileView(trainee: model as TraineeModel),
      ),
    );
  }
}
