import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:be_fitness_app/main.dart';
import 'package:be_fitness_app/view/onboarding/screens/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sizer/sizer.dart';

import 'core/theme/colors_schemes.dart';
import 'core/theme/custom_color.dart';

class BeFitnessApp extends MaterialApp {
  final ColorScheme darkScheme;
  final ColorScheme lightScheme;
  BeFitnessApp(
    RouteGenerator routeGenerator,
    this.darkScheme,
    this.lightScheme, {
    super.key,
  }) : super(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightScheme,
              textTheme: TextTheme(
                  bodyLarge:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800),
                  bodyMedium: TextStyle(fontSize: 14.sp)),
              extensions: [lightCustomColors],
            ),
            darkTheme: ThemeData(
              fontFamily: 'IntegralCF-Regular',
              textTheme: TextTheme(
                  bodyLarge: TextStyle(
                      fontFamily: 'IntegralCF',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800),
                  bodyMedium: TextStyle(
                      fontFamily: 'IntegralCF-Regular', fontSize: 15.sp)),
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
            builder: (context, child) => ResponsiveBreakpoints.builder(
                  child: child!,
                  breakpoints: [
                    const Breakpoint(start: 0, end: 450, name: MOBILE),
                    const Breakpoint(start: 451, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    const Breakpoint(
                        start: 1921, end: double.infinity, name: '4K'),
                  ],
                ),
            themeMode: ThemeMode.dark,
            initialRoute: !pref!.getBool('first')!
                ? DecisionsTree.routeName
                : OnBoardingPage.routeName,
            onGenerateRoute: routeGenerator.generateRoute);
}
