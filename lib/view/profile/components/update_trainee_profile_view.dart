import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:flutter/material.dart';

class UpdateTraineeProfileView extends StatelessWidget {
  final TraineeModel trainee;
  const UpdateTraineeProfileView({super.key, required this.trainee});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(
        onPressed: () async {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(30, 30)),
        ),
        child: const Text('get token'),
      ),
    );
  }
}
