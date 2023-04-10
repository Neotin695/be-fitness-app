import 'package:be_fitness_app/view/auth/screens/welcome_screen.dart';
import 'package:be_fitness_app/view/getstarted/screens/getstarted_screen.dart';
import 'package:be_fitness_app/view/home/screens/home_layout.dart';
import 'package:be_fitness_app/view/verifycoach/screens/not_accepted_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DecisionsTree extends StatelessWidget {
  static const String routeName = 'decision';
  const DecisionsTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('tempuser')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final String status =
                    (snapshot.data!.data() as Map<String, dynamic>)['status'];
                if (status == 'notAccepted') {
                  return const NotAcceptedScreen();
                } else if (status == 'new') {
                  return const GetStartedScreen();
                }
                return const HomeLayoutScreen();
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
