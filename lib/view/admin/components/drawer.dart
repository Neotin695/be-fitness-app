import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/view/admin/view/body_part_page.dart';
import 'package:be_fitness_app/view/admin/view/main_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../view/excercise_page.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 20.h,
            color: Colors.blue,
            child: const Center(
              child: Text(AppConst.brandTxt),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushReplacementNamed(
                context, MainAdminPage.routeName),
          ),
          ListTile(
            title: const Text('Add body part'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () =>
                Navigator.pushReplacementNamed(context, BodyPartPage.routeName),
          ),
          ListTile(
            title: const Text('Add excercise'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushReplacementNamed(
                context, ExcercisePage.routeName),
          ),
        ],
      ),
    );
  }
}
