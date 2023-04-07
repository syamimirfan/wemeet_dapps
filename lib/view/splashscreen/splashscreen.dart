import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/view/lecturers/home_lecturers.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
    @override
   void initState() {
    getValidateData();

    super.initState();
   }

    void getValidateData() async{
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      Timer(const Duration(seconds: 5), () {
          if(_sharedPreferences.getString('matricNo') == null && _sharedPreferences.getString('staffNo') == null) {
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
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: Device.screenType == ScreenType.tablet ?
            EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 5.0.h) :
            EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 3.0.h), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Padding(
                    padding:  const EdgeInsets.symmetric(vertical: 20, horizontal: 70), 
                    child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Text("We", 
                        style: TextStyle(
                        color: Constants().secondaryColor,
                        fontWeight: FontWeight.bold, 
                         fontFamily: 'Poppins',
                         fontSize: 40 
                        ),
                      ),
                      Text("Meet", 
                        style: TextStyle(
                        color: Constants().tertiaryColor,
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Poppins',
                        fontSize: 40,
                        ),
                      ),
                    ],
                   ),
                 ),
                
                  Text("Make an appointment with your lecturer",
                          style: TextStyle(
                            color: Constants().tertiaryColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                      ),
                  ),
                  const SizedBox(height: 30,),
        
                  Image.asset("assets/splashscreen1.png"),
        
                  const SizedBox(height: 30,),
        
                  Text("Make an appointment with your favorite lecturer",
                  textAlign: TextAlign.center ,
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins', 
                    fontSize: 16,
                   ),
                  ),
                  Text("@ Universiti Tun Hussein Onn Malaysia",
         
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w500,
      
                    fontSize: 16,
                    fontFamily: 'Poppins',
                   ),
                  ),
                  Text("(UTHM)",
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                   ),
                  ),
        
               const SizedBox(height: 22,),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                       Text("Loading ", style: TextStyle(fontFamily: 'Poppins',fontSize: 20, color: Constants().secondaryColor, fontWeight: FontWeight.w600 ),),
                      SpinKitThreeBounce(color: Constants().secondaryColor, size: 25)
                  ],
                ),
 
              ],
            ),
          ),
        ),
    );
  }
}