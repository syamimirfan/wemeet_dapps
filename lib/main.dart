import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';


final  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> main() async{
  //to off the auto rotate (disable landscape mode)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await Firebase.initializeApp();
   final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  FirebaseMessaging.instance.getToken().then((value) => {
      print("getToken : $value"),
      //set the for the notification
      _sharedPreferences.setString("tokenNotification", value!),
      print(value)
  });

  //if Application is in Background, then it will work
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      Navigator.pushNamed(navigatorKey.currentState!.context, '/splashscreen');
  });

  //if App is closed/terminated, then it will work
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      Navigator.pushNamed(navigatorKey.currentState!.context, '/splashscreen');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //local notifications
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(const MyApp());
  configLoading();
}

Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message) async{
  await Firebase.initializeApp();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..textStyle = TextStyle(  
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins', 
    );
}

 class MyApp extends StatefulWidget {
   const MyApp({super.key});
 
   @override
   State<MyApp> createState() => _MyAppState();
 }
  
 class _MyAppState extends State<MyApp> {


   @override
   void initState() {
    super.initState();
   }


   @override
   Widget build(BuildContext context) {
     return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Constants().primaryColor,
      ), 
      home: SplashScreen(),
      locale: Locale('en', 'US'),  
      builder: EasyLoading.init(),
      navigatorKey: navigatorKey,
      routes: {
        '/splashscreen': ((context) => SplashScreen())
      },
     );
    }
  );
   }
 }