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
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
                     height: Device.screenType == ScreenType.tablet?  849: deviceHeight(context) * 3,
                     width: Device.screenType == ScreenType.tablet?  1000: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) *0.07),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                          SizedBox(height: deviceHeight(context) * 0.03,),
                          Image.asset('assets/UTHM2.png'),
                          SizedBox(height: deviceHeight(context) * 0.02,),
                           Container(
                            padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.08),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                   Text(
                                  "WeMeet Version 0",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                    Text(
                                  "UTHM Official Student-Lecturer Appointment App",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                    Text(
                                  "Copyright © 2022-2023 Universiti Tun Hussein Onn Malaysia(UTHM). All rights reserved ",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                    Text(
                                  "http://www.uthm.edu.my",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                    ),
                                    ),
                                    
                                    Text(
                                  "Developed by Syamim Irfan(AI200104)",
                            
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                    Text(
                                  "Suggestions?",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                    Text(
                                  "Please email to ai200104@siswa.uthm.edu",
                          
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
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