import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/model/providerModel.dart';
import 'package:tscoffee/view/login.dart';
import 'view/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late final ValueNotifier<int> notifier;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print(message.notification);
}

void main(List<String> args) async {
// ...
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getPer();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
  configLoading();
}

Future<void> getPer() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );
  NotificationSettings settings = await messaging.getNotificationSettings();
  FirebaseMessaging.instance
      .getToken(
          vapidKey:
              "BDXZTE58vYfdDFvicZZbkdsTlef3Kgki75J3NMnrbCCs2eUlHmOtedOd6y7c9-G116DEg7aaomrp3IJKx_1S_eE")
      .then((value) {
    print(value);

    print('User granted permission: ${settings.authorizationStatus}');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..maskType = EasyLoadingMaskType.black
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

Future showFlutterNotification(RemoteMessage message) async {
  if (message.notification != null) {
    print("test");
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TSCoffee',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              // Set the predictive back transitions for Android.
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
            },
          ),
        ),
        home: const HomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    bool isLogin = WebStorage.instance.sessionId.toString() != "null" &&
        WebStorage.instance.sessionId.toString() != "";
    return isLogin ? Home() : Login();
  }
}
