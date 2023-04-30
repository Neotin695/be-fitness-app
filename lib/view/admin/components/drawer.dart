import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/view/admin/view/main_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../home/screens/home_layout_page.dart';
import '../view/excercise_admin_page.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 25.h,
              color: Colors.blue,
              child: Center(
                child: Text(
                  AppConst.brandTxt,
                  style: TextStyle(fontSize: 25.sp),
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushReplacementNamed(
                  context, MainAdminPage.routeName),
            ),
            ListTile(
              title: const Text('Main App'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  Navigator.pushNamed(context, HomeLayoutPage.routeName),
            ),
            ListTile(
              title: const Text('Add excercise'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  Navigator.pushNamed(context, ExcerciseAdminPage.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
