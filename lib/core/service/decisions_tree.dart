import 'package:be_fitness_app/view/admin/view/main_admin_page.dart';
import 'package:be_fitness_app/view/auth/screens/welcome_screen.dart';
import 'package:be_fitness_app/view/getstarted/screens/getstarted_screen.dart';
import 'package:be_fitness_app/view/home/screens/home_layout_page.dart';
import 'package:be_fitness_app/view/verifycoach/screens/not_accepted_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appconstance/logic_constance.dart';

class DecisionsTree extends StatelessWidget {
  static const String routeName = 'decision';
  const DecisionsTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.email == 'mehani695@gmail.com') {
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
                      'mehani695@gmail.com') {
                    return const MainAdminPage();
                  }
                  return const GetStartedScreen();
                } else if (status == LogicConst.authenticate) {
                  return const HomeLayoutPage();
                }
                return const WelcomeScreen();
              }
              return const WelcomeScreen();
            },
          );
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
