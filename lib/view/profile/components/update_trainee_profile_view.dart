import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:flutter/material.dart';

class UpdateTraineeProfileView extends StatelessWidget {
  final TraineeModel trainee;
  const UpdateTraineeProfileView({super.key, required this.trainee});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Text('Trainee Profile'));
  }
}
