import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                   EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.01,),
             child: Container(
                      decoration:  const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                          Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 137, 122, 252),
                          ],
                        ),
                      // color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                       )
                      ),
                     height: Device.screenType == ScreenType.tablet?  deviceHeight(context) * 3: deviceHeight(context) * 3,
                     width: Device.screenType == ScreenType.tablet?  deviceWidth(context) * 3: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) *0.07),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                          SizedBox(height: deviceHeight(context) * 0.03,),
                          Center(
                            child:  Image.asset('assets/UTHM2.png'),
                          ),
                          SizedBox(height: deviceHeight(context) * 0.02,),
                           Container(
                            padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.08),
                                 child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                     Flexible(
                                       child: Text(
                                           "WeMeet Version 0.2",
                                            style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                          fontSize: Device.screenType == ScreenType.tablet? 18:18,
                                         fontFamily: 'Poppins',
                                           ),
                                        ),
                                     ),
                                      Flexible(
                                  child: Text(
                                "UTHM Official Student-Lecturer Appointment App",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Device.screenType == ScreenType.tablet
                                      ? 
                                      15:15,
                                   fontFamily: 'Poppins',
                                   ),
                                  ),
                                      ),
                                      Flexible(
                                        child: Text(
                                    "Copyright © 2022-2023 Universiti Tun Hussein Onn Malaysia(UTHM). All rights reserved ",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize:  Device.screenType == ScreenType.tablet? 
                                      15:15,
                                    fontFamily: 'Poppins',
                                    ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                      "http://www.uthm.edu.my",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize:  Device.screenType == ScreenType.tablet? 
                                        15:15,
                                       fontFamily: 'Poppins',
                                        ),
                                        ),
                                      ),                                     
                                      Flexible(
                                        child: Text(
                                        "Developed by Syamim Irfan(AI200104)",                        
                                        style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:  Device.screenType == ScreenType.tablet? 
                                        15:15,
                                        fontFamily: 'Poppins',
                                      ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                        "Suggestions?",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:  Device.screenType == ScreenType.tablet? 
                                         15:15,
                                        fontFamily: 'Poppins',
                                        ),
                                        ),
                                      ),
                                      Flexible(
                                        child: SelectableText(
                                        "Please email to syamimirfan59@gmail.com",
                          
                                        style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:  Device.screenType == ScreenType.tablet? 
                                        15:15,
                                      fontFamily: 'Poppins',
                                      ),
                                        ),
                                      ),
                                    ],
                                  ),
                           
                             ),
                           
                            ],
                          ),
                        ),
                      ),
                    ),
                
            
          
      ),
      
    );
  }
}