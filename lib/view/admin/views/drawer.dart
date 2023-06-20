import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/view/admin/pages/main_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../home/pages/home_layout_page.dart';
import '../pages/excercise_admin_page.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 25.h,
              color: Theme.of(context).colorScheme.onSecondary,
              child: Center(
                child: Text(
                  AppConst.brandTxt,
                  style: TextStyle(fontSize: 25.sp),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushReplacementNamed(
                  context, MainAdminPage.routeName),
            ),
            ListTile(
              title: Text(
                'Main App',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  Navigator.pushNamed(context, HomeLayoutPage.routeName),
            ),
            ListTile(
              title: Text(
                'Add excercise',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
