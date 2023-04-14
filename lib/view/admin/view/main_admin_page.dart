import 'package:be_fitness_app/view/admin/components/main_admin_view.dart';
import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAdminPage extends StatelessWidget {
  static const String routeName = 'mainAdmin_page';
  const MainAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Admin'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocProvider(
        create: (context) => AdminCubit(),
        child: const MainAdminView(),
      ),
    );
  }
}
