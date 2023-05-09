import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/music_player_view.dart';
import '../cubit/music_player_cubit.dart';

class MusicPlayerPage extends StatelessWidget {
  static const String routeName = '/musicPlayer';
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return Scaffold(
      body: BlocProvider(
        create: (context) => MusicPlayerCubit(),
        child: SafeArea(
          child: MusicPlayerView(
            index: int.parse(args[0].toString()),
            excercise: args[1] as ExcerciseModel,
          ),
        ),
      ),
    );
  }
}
