import 'package:be_fitness_app/be_fitness_app.dart';
import 'package:be_fitness_app/core/service/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';

import 'core/service/firebase/firebase_options.dart';
import 'core/service/notification/messaging.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Messaging().initialNotification();
  FirebaseMessaging.onMessage.listen((event) {
    RemoteNotification notification = event.notification!;
    AndroidNotification android = event.notification!.android!;

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
    RemoteNotification notification = event.notification!;
    AndroidNotification android = event.notification!.android!;

    if (event.notification != null) {}
  });
  await Messaging().notificationPlugIn();
  await Messaging().setForegroundNotification();
  runApp(const MainWidget());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

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
        navigatorKey: navigatorKey,
      );
    });
  }
}
