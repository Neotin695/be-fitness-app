import 'package:be_fitness_app/view/admin/pages/main_admin_page.dart';
import 'package:be_fitness_app/view/auth/pages/auth_sign_page.dart';
import 'package:be_fitness_app/view/getstarted/pages/getstarted_page.dart';
import 'package:be_fitness_app/view/home/pages/home_layout_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../view/coach/pages/not_accepted_screen.dart';
import '../appconstance/logic_constance.dart';

class DecisionsTree extends StatelessWidget {
  static const String routeName = 'decision';
  const DecisionsTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.email == 'mehani695@gmail.com' ||
                FirebaseAuth.instance.currentUser!.email ==
                    'asia24954@gmail.com') {
              return const MainAdminPage();
            }
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection(LogicConst.tempUser) 
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final String status = (snapshot.data!.data()
                      as Map<String, dynamic>)[LogicConst.status];
                  if (status == LogicConst.unauthenticate) {
                    return const NotAcceptedScreen();
                  } else if (status == LogicConst.newTxt) {
                    if (FirebaseAuth.instance.currentUser!.email ==
                            'mehani695@gmail.com' ||
                        FirebaseAuth.instance.currentUser!.email ==
                            'asia24954@gmail.com') {
                      return const MainAdminPage();
                    }
                    return const GetStartedScreen();
                  } else if (status == LogicConst.authenticate) {
                    return const HomeLayoutPage();
                  }
                  return const AuthSignInPage();
                }
                return const AuthSignInPage();
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    size: 35.sp));
          } else {
            return const AuthSignInPage();
          }
        },
      ),
    );
  }
}
