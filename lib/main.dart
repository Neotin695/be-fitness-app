import 'package:be_fitness_app/be_fitness_app.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/service/firebase/firebase_options.dart';
import 'core/service/notification/messaging.dart';
import 'core/theme/colors_schemes.dart';
import 'core/theme/custom_color.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

SharedPreferences? pref;

initShared() async {
  pref = await SharedPreferences.getInstance();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initShared();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Messaging().initialNotification();
  FirebaseMessaging.onMessage.listen((event) {
    RemoteNotification notification = event.notification!;

    if (event.notification != null) {
      Messaging().flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  Messaging.channel.id, Messaging.channel.name,
                  channelDescription: Messaging.channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ),
          );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {

    if (event.notification != null) {}
  });
  await Messaging().notificationPlugIn();
  await Messaging().setForegroundNotification();
  if (pref!.getBool('first') == null) {
    await pref!.setBool('first', true);
  }
  runApp(DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    ColorScheme lightScheme;
    ColorScheme darkScheme;

    if (lightDynamic != null && darkDynamic != null) {
      lightScheme = lightDynamic.harmonized();
      lightCustomColors = lightCustomColors.harmonized(lightScheme);

      darkScheme = darkDynamic.harmonized();
      darkCustomColors = darkCustomColors.harmonized(darkScheme);
    } else {
      lightScheme = lightColorScheme;
      darkScheme = darkColorScheme;
    }
    return MainWidget(lightScheme: lightScheme, darkScheme: darkScheme);
  }));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MainWidget extends StatefulWidget {
  final ColorScheme darkScheme;
  final ColorScheme lightScheme;
  const MainWidget(
      {super.key, required this.darkScheme, required this.lightScheme});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
    Messaging().onMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BeFitnessApp(
        RouteGenerator(),
        widget.darkScheme,
        widget.lightScheme,
      );
    });
  }
}
