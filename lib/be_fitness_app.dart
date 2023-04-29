import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class BeFitnessApp extends MaterialApp {
  BeFitnessApp(RouteGenerator routeGenerator)
      : super(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.indigo,
            ),
            builder: (context, child) {
              return ResponsiveWrapper.builder(child,
                  maxWidth: 1200,
                  minWidth: 480,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(480, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                  ],
                  background: Container(color: const Color(0xFFF5F5F5)));
            },
            initialRoute: DecisionsTree.routeName,
            onGenerateRoute: routeGenerator.generateRoute);
}


/* 
{
          '/': (_) => const DecisionsTree(),
          MainAdminPage.routeName: (_) => const MainAdminPage(),
          ReviewPage.routeName: (_) => const ReviewPage(),
          WelcomeScreen.routeName: (_) => const WelcomeScreen(),
          GetStartedScreen.routeName: (_) => const GetStartedScreen(),
          VerifyCoachScreen.routeName: (_) => const VerifyCoachScreen(),
          CreateProfileScreen.routeName: (_) => const CreateProfileScreen(),
          NotAcceptedScreen.routeName: (_) => const NotAcceptedScreen(),
          HomeLayoutPage.routeName: (_) => const HomeLayoutPage(),
          BodyPartPage.routeName: (_) => const BodyPartPage(),
          ExcerciseAdminPage.routeName: (_) => const ExcerciseAdminPage(),
          ChatRoomPage.routeName: (_) => const ChatRoomPage(),
          MessagePage.routeName: (_) => const MessagePage(),
          ExcercisePage.routeName: (_) => const ExcercisePage(),
          PlayExcercisePage.routeName: (_) => const PlayExcercisePage(),
          ProfilePage.routeName: (_) => const ProfilePage(),
        }, */