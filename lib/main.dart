import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tscoffee/model/Pushnotifier.dart';
import 'package:tscoffee/model/WebStorage.dart';
import 'package:tscoffee/view/login.dart';
import 'view/home.dart';
late final ValueNotifier<int> notifier;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  notifier = ValueNotifier(int.parse(localStorage.getItem('counter') ?? '0'));
  notifier.addListener(() {
    localStorage.setItem('counter', notifier.value.toString());
  });
  Pushnotifier.init();
  FirebaseMessaging.onBackgroundMessage(showFlutterNotification);
  runApp(const MyApp());
  
  configLoading();  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

void configLoading(){
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
Future showFlutterNotification(RemoteMessage message) async{
  if(message.notification!=null){

  print("test");
  }
 
}
class _MyAppState extends State<MyApp> {
  
  
  @override
  void initState(){
    super.initState();

  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
        builder: EasyLoading.init(),);
        
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    bool isLogin = WebStorage.instance.sessionId.toString() != "null";
    return isLogin ?Home():Login();
  }
}
