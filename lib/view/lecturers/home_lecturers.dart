import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';


class HomeLecturer extends StatefulWidget {
  const HomeLecturer({super.key});

  @override
  State<HomeLecturer> createState() => _HomeLecturerState();
}

class _HomeLecturerState extends State<HomeLecturer> {

  @override
  Widget build(BuildContext context) {
      double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
      double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "Home",
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
            icon: const Icon(Icons.info_outline_rounded),
            ),
        ],
      ),
      drawer: MainDrawerLecturer(home: true, profile: false, slot: false, appointment: false, attendance: false, chat: false),
       body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Padding(
                  padding: Device.screenType == ScreenType.tablet?  
                    const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.09,),
                  child:  Container(
                    child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                    Text(
                  "Hello, ",
                   style: TextStyle(
                    color: Colors.white,
                    fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.32.dp,
                    fontFamily: 'Poppins',
                   ),
                ),
                  ]),
                  ),
                ),
                     
                 Padding(
                  padding:  Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.09,),
                   child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children:  [
                         const SizedBox(height: 40,),
                     Flexible(
                      child: Text(
                      "DR NUR ARIFFIN BIN MOHD ZIN",
                       style: TextStyle(
                       color: Colors.white,
                       fontSize:  Device.screenType == ScreenType.tablet?  
                                  0.18.dp: 0.26.dp,  
                       fontWeight: FontWeight.bold,
                       fontFamily: 'Poppins',
                         ),
                       ),
                     ),
                      SizedBox(width: deviceWidth(context) * 0.07,),
                        Icon(Icons.waving_hand, color: const Color(0xFFFFDD67), size:Device.screenType == ScreenType.tablet?  0.2.dp: 0.4.dp,),
                    ],
                   ),
                 ),
                   const SizedBox(height: 20,),
         
                   Padding(
                  padding: Device.screenType == ScreenType.tablet?  
                   const EdgeInsets.symmetric(horizontal: 40,):
                   const EdgeInsets.symmetric(horizontal: 30,),
                  child: Container(
                    child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(
                  "Welcome Back",
                   style: TextStyle(
                    color: Colors.white,
                    fontSize:  Device.screenType == ScreenType.tablet?  
                               0.30.dp:0.40.dp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                   ),
                ),
                  ]),
                  ),
                ),
            
         
                const SizedBox(height: 36,),
                
                Flexible(
                  child: Container(
                      decoration:  const BoxDecoration(
                      color: Colors.white,
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
                          padding: const EdgeInsets.only(top: 20,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                               const Text(
                                "Appointment Requests",
                               style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                               ),
                              ),
                      for(int i = 0; i < 5; i++) 
                               Container(
                                  margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03, vertical: deviceHeight(context) * 0.02),
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
                                   children: [
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                              radius: 60,
                                              backgroundImage: AssetImage("assets/student.png"),
                                          ),
                                        ),
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
                                              "AI200104",
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
                                              "MUHAMAD SYAMIM IRFAN BIN AHMAD SHOKKRI",
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
                                              "0194078581",
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
                                              "1 students",
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
                                const SizedBox(width: 50,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                    width: deviceWidth(context) * 0.30,
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().secondaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        showConfirmationRejectBox(context, "Confirm?", "Are you sure to reject this session?");
                                      },
                                      child: const Text(
                                        "Reject",
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
                                    width: deviceWidth(context) * 0.30,
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().acceptedColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        showConfirmationAcceptBox(context, "Confirm?", "Are you sure to accept this session?");
                                      },
                                      child: const Text(
                                        "Accept",
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
                ),
              ],
             ),
           ),
    );
  }

  //message to confirmation of action for reject request from the lecturer (DELETE booking from the database)
  static void showConfirmationRejectBox(BuildContext context, String title, String message) {
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
    
    //message to confirmation of action for accept request from the lecturer (UPDATE statusBooking from database)
    //MAKE SURE TO REMOVE THE APPOINTMENT THAT HAS BEEN ACCEPTED FROM THE UI
    static void showConfirmationAcceptBox(BuildContext context, String title, String message) {
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
            print("APPOINTMENT ACCEPTED");
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }
}