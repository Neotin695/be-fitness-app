import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/display_reviews_view.dart';

class DisplayReviewsPage extends StatelessWidget {
  static const String routeName = '/displayReviews';
  const DisplayReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: BlocProvider(
        create: (_) => CoachCubit(),
        child: DisplayReviewsView(
          userId: args,
        ),
      ),
    );
  }
}
