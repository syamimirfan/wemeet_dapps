import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';

Future<void> main() async{

  //to off the auto rotate (disable landscape mode)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  //local notifications
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(const MyApp());
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

     );
    }
  );
   }
 }