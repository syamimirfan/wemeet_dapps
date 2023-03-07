import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
            "Appointment",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
             IconButton(
              onPressed: () { 
                nextScreen(context, About());
              },
              icon: Icon(Icons.info_outline_rounded)
             ),
          ],
      ),
    drawer: MainDrawerLecturer(home: false, profile: false, slot: false, appointment: true, attendance: false, chat: false),
      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
        child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
               color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
               ),
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                    for (int i = 0; i < 5; i++) 
                     Container(
                          margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03, vertical: deviceHeight(context) * 0.04),
                            padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.009),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Constants().BoxShadowColor,
                            ),
                            boxShadow:  [
                                    BoxShadow(
                                      color: Constants().BoxShadowColor,
                                      offset: const Offset(0, 10),
                                      blurRadius: 15,
                                      spreadRadius: 0,
                                    ),
                                  ],
                          ),
                          child: Column(
                            children:[
                            //for booking information
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                //for lecturer images
                                  Container(
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage("assets/student.png"),
                                    ),
                                  ),
                                  //for booking information
                                  Flexible(
                                    child: Container(
                                       margin:  Device.screenType == ScreenType.tablet? 
                                      const EdgeInsets.only(left: 20):
                                      EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                             "MUHAMAD SYAMIM IRFAN BIN AHMAD SHOKKRI",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                              0.18.dp: 0.28.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                           Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "1 student",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                              0.16.dp: 0.26.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                           Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "16 OCT SUN",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                              0.16.dp: 0.26.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                           Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "10.00 AM",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                               0.16.dp: 0.26.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Constants().secondaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                               ],
                            ),

                          //for divider between booking information and button
                          Divider(
                             color: Constants().dividerColor,
                             thickness: 1.5,
                            ),

                            //for button contact lecturer and update
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: deviceWidth(context) * 0.19,
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                    
                                      },
                                      child: const Text(
                                        "Contact Student",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                                   SizedBox(
                                  width: deviceWidth(context) * 0.13,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().secondaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                      showConfirmationDeleteBox(context, "Confirm?", "Are you sure to delete this session?");
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                              ],
                            ), 
                    
                          ],
                        ),
                     ),
                   ],
                ),
            ),
        ),
      ),
    );
  }

  //message to confirmation of action for delete accepted from the lecturer (DELETE booking from the database)
  static void showConfirmationDeleteBox(BuildContext context, String title, String message) {
    showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 20),),
        content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 13),),
        actions: [
         IconButton(
          onPressed: () {
          nextScreenPop(context);
           },
          icon: const Icon(Icons.cancel,color: Colors.red,size: 30,),
           ),
          IconButton(onPressed: () async{
             print("APPOINTMENT DELETED!");
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }
}