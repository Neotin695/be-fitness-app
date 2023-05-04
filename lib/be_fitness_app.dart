import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:be_fitness_app/main.dart';
import 'package:be_fitness_app/view/onboarding/screens/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:sizer/sizer.dart';

import 'core/theme/colors_schemes.dart';
import 'core/theme/custom_color.dart';

class BeFitnessApp extends MaterialApp {
  @override
  // ignore: overridden_fields
  final GlobalKey<NavigatorState> navigatorKey;
  final ColorScheme darkScheme;
  final ColorScheme lightScheme;
  BeFitnessApp(RouteGenerator routeGenerator, this.darkScheme, this.lightScheme,
      {super.key, required this.navigatorKey})
      : super(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'IntegralCF',
              useMaterial3: true,
              colorScheme: lightScheme,
              textTheme: TextTheme(
                  bodyLarge:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800),
                  bodyMedium: TextStyle(fontSize: 14.sp)),
              extensions: [lightCustomColors],
            ),
            darkTheme: ThemeData(
              fontFamily: 'IntegralCF',
              textTheme: TextTheme(
                  bodyLarge:
                      TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w800),
                  bodyMedium:
                      TextStyle(fontFamily: 'IntegralCF', fontSize: 10.sp)),
              useMaterial3: true,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(60.w, 9.h)),
                maximumSize: MaterialStateProperty.all(Size(60.w, 9.h)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
              )),
              colorScheme: darkColorScheme,
              extensions: [darkCustomColors],
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
            themeMode: ThemeMode.dark,
            initialRoute: pref!.getBool('first')!
                ? OnBoardingPage.routeName
                : DecisionsTree.routeName,
            onGenerateRoute: routeGenerator.generateRoute);
}
