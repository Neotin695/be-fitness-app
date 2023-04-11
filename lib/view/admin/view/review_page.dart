import 'package:be_fitness_app/models/request_online_coach.dart';
import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/review_admin_view.dart';

class ReviewPage extends StatelessWidget {
  static const String routeName = 'reviewPage';
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestOnlineCoachModel request =
        ModalRoute.of(context)!.settings.arguments as RequestOnlineCoachModel;

    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AccepteRequest) {
          Navigator.pop(context);
        } else if (state is RejectRequest) {
          Navigator.pop(context);
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Review Request'),
            ),
            body: BlocProvider(
              create: (context) => AdminCubit(),
              child: ReviewAdminView(
                request: request,
              ),
            ));
      },
    );
  }
}
