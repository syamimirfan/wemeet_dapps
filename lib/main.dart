import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/view/lecturers/home_lecturers.dart';
import 'package:wemeet_dapps/view/splashscreen/splashscreen.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:flutter/services.dart';

Future<void> main() async{

  //to off the auto rotate (disable landscape mode)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(const MyApp());
}

 class MyApp extends StatefulWidget {
   const MyApp({super.key});
 
   @override
   State<MyApp> createState() => _MyAppState();
 }
 
 class _MyAppState extends State<MyApp> {
   
   late SharedPreferences _sharedPreferences;

   @override
   void initState() {
    super.initState();

    isLoginStudent();
   }

   void isLoginStudent() async{
    _sharedPreferences = await SharedPreferences.getInstance();
      Timer(const Duration(minutes: 30), () {
          if(_sharedPreferences.getString('matricNo') == null || _sharedPreferences.getString('staffNo') == null) {
              nextScreenReplacement(context, Login());
          }else {
            if(_sharedPreferences.getInt('statusStudent') == 1) {
              nextScreenReplacement(context, HomeStudents());
            } else if(_sharedPreferences.getInt('statusLecturer') == 2) {
              nextScreenReplacement(context, HomeLecturer());
            }
          }
      });
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