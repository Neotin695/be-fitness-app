import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class BeFitnessApp extends MaterialApp {
  final GlobalKey<NavigatorState> navigatorKey;
  BeFitnessApp(RouteGenerator routeGenerator,
      {super.key, required this.navigatorKey})
      : super(
            navigatorKey: navigatorKey,
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
