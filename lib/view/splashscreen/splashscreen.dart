import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: Device.screenType == ScreenType.tablet ?
            EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 5.0.h) :
            EdgeInsets.symmetric(vertical: 7.0.h, horizontal: 3.0.h), 
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
        
                  SizedBox(
                    width: double.infinity,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().secondaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                      ),
                      onPressed: () {
                         nextScreen(context,  Login());
                    
                      },
                      child: const Text(
                        "Get Started",
                           style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             fontFamily: 'Poppins',
                        )
                      ),
                     ),
                  ),
              ],
            ),
          ),
        ),
    );
  }
}