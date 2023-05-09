import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/add_review_view.dart';
import '../cubit/coach_cubit.dart';

class AddReviewPage extends StatelessWidget {
  static const String routeName = '/addReview';
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Write a Review'),
      ),
      body: BlocProvider(
        create: (context) => CoachCubit(),
        child: AddReviewView(userId: args),
      ),
    );
  }
}
