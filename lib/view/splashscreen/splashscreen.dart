import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/view/lecturers/home_lecturers.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
    final connectivityResult = await Connectivity().checkConnectivity();
      Timer(const Duration(seconds: 5), () {
          if (connectivityResult == ConnectivityResult.none) {
            showErrorMessage(context, "No Internet Connection", "Please make sure you connect with the internet", "Ok");
          } else if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
              //if internet is detected
            if(_sharedPreferences.getString('matricNo') == null && _sharedPreferences.getString('staffNo') == null) {
           nextScreenReplacement(context, Login());
          }else {
            if(_sharedPreferences.getInt('statusStudent') == 1) {
              nextScreenReplacement(context, HomeStudents());
            } else if(_sharedPreferences.getInt('statusLecturer') == 2) {
               nextScreenReplacement(context, HomeLecturer());
            }
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
                    child:  Expanded(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [          
                        Text("We", 
                          style: TextStyle(
                          color: Constants().secondaryColor,
                          fontWeight: FontWeight.bold, 
                           fontFamily: 'Poppins',
                           fontSize: Device.screenType == ScreenType.tablet? 
                                30:30,
                          ),
                        ),
                        Text("Meet", 
                          style: TextStyle(
                          color: Constants().tertiaryColor,
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'Poppins',
                          fontSize: Device.screenType == ScreenType.tablet? 
                                30:30,
                          ),
                        ),
                      ],
                                       ),
                    ),
                 ),
                
                  Text("Make an appointment with your lecturer",
                     textAlign: TextAlign.center ,
                          style: TextStyle(
                            color: Constants().tertiaryColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontSize: Device.screenType == ScreenType.tablet? 
                             15:15,
                      ),
                  ),
                  const SizedBox(height: 30,),
        
                  Image.asset("assets/splashscreen1.png"),
        
                  const SizedBox(height: 30,),
        
                  Text("Make an appointment with your favorite lecturer",
                  textAlign: TextAlign.center ,
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins', 
                    fontSize: Device.screenType == ScreenType.tablet? 
                              15 : 15,
                   ),
                  ),
                  Text("@ Universiti Tun Hussein Onn Malaysia",
                    textAlign: TextAlign.center ,
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w400,
      
                    fontSize: Device.screenType == ScreenType.tablet? 
                              15 : 15,
                    fontFamily: 'Poppins',
                   ),
                  ),
                  Text("(UTHM)",
                   textAlign: TextAlign.center ,
                   style: TextStyle(
                    color: Constants().tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: Device.screenType == ScreenType.tablet? 
                            15:15,
                    fontFamily: 'Poppins',
                   ),
                  ),
        
               const SizedBox(height: 22,),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                       Text("Loading ", style: TextStyle(fontFamily: 'Poppins',fontSize: Device.screenType == ScreenType.tablet? 
                              15:15, color: Constants().secondaryColor, fontWeight: FontWeight.w600 ),),
                      SpinKitThreeBounce(color: Constants().secondaryColor, size: 15)
                  ],
                ),
 
              ],
            ),
          ),
        ),
    );
  }

   //error message if there is no internet connection
  static void showErrorMessage(BuildContext context, String title, String message, String buttonText) {
      showDialog(context: context,
       builder: (BuildContext context) {
        return AlertDialog( 
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
          content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
          actions: [
             ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor),textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              child:  Text(buttonText),
              onPressed: () {
                 SystemNavigator.pop();
              },
            )
          ],
         );
        }
       );
  }
}