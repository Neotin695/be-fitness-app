import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/admin/views/main_admin_view.dart';
import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/drawer.dart';

class MainAdminPage extends StatelessWidget {
  static const String routeName = '/mainAdminPage';
  const MainAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerAdmin(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Main Admin'),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, DecisionsTree.routeName)),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocProvider(
        lazy: false,
        create: (context) => AdminCubit(),
        child: const MainAdminView(),
      ),
    );
  }
}
