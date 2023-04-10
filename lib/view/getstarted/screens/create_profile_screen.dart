import 'package:be_fitness_app/view/getstarted/cubit/getstarted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/body_getstarted.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String routeName = 'createProfileScreen';
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen>
    with RestorationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => GetstartedCubit(),
        child: const BodyStarted(),
      ),
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => 'create_profile';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
  }
}
