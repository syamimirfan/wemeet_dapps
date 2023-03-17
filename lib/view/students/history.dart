import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class ManageHistory extends StatefulWidget {
  const ManageHistory({super.key});

  @override
  State<ManageHistory> createState() => _ManageHistoryState();
}

class _ManageHistoryState extends State<ManageHistory> {

  //variable for booking status
  List<String> statusAttendance = ["Attend", "Absent", "Attend", "Absent","Attend"];

  //variable for booking information
  List<String> images = ["assets/lecturer.png", "assets/icon.png","assets/icon.png","assets/icon.png","assets/icon.png"];
  List<String> lecturerName = ["Nur Ariffin Bin Mohd Zin", "Zainuri Bin Saringat", "Salama A Mostafa", "Mazidah Binti Mat Rejab", "Noraini Binti Ibrahim"];
  List<int> number = [1,3,2,6,10];
  List<String> date = ["16 OCT SUN","16 OCT SUN","27 JAN Fri","16 OCT SUN","16 OCT SUN"];
  List<String> time = ["10.00 AM","10.00 AM","10.00 AM","10.00 AM","10.00 AM"];

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
            "History",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
         actions: [
            IconButton(
              onPressed: () { 
                nextScreen(context, About());
              },
              icon: Icon(Icons.info_outline_rounded)
             ),
          ],
      ),
      drawer: MainDrawerStudent(home: false, profile: false, book: false, appointment: false, reward: false, chat: false, yourHistory: true),

      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                 const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                 EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
        child: Container(
            height: 100.h,
            width: 100.w,
            decoration:  const BoxDecoration(
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
                  for(int i = 0; i < 5; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal:  deviceWidth(context) * 0.03, vertical: deviceHeight(context) * 0.03),
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.07, vertical: deviceHeight(context) * 0.01 ),
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20), 
                         color: Colors.white,
                         border: Border.all(
                            color: Constants().BoxShadowColor,
                         ),
                         boxShadow: [
                               BoxShadow(
                                  color: Constants().BoxShadowColor,
                                  offset: const Offset(0, 10),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                              ),
                         ]
                      ),
                      child: Column(
                        children: [
                          //for status attendance
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  "Status: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  statusAttendance[i],
                                  style: TextStyle(
                                    color: statusAttendance[i] == "Attend" ? Constants().acceptedColor :
                                           statusAttendance[i] == "Absent" ? Constants().secondaryColor : 
                                           Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                            ],
                          ),

                          //for booking information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Container(
                                  //for lecturer images
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(images[i]),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Flexible(
                                child: Container(
                                  margin: Device.screenType == ScreenType.tablet? 
                                          const EdgeInsets.only(left: 20) :
                                          EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "DR "+ lecturerName[i],
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
                                              number[i].toString() +" Student",
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
                                              date[i],
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
                                              time[i],
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                               0.16.dp: 0.26.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                        ),
                                    ],
                                  ),
                                )
                               ),
                            ],
                          ),
                         //for divider between booking information and button
                          Divider(
                            color: Constants().dividerColor,
                            thickness: 1.5,
                          ),

                          //for button Meet Again
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: deviceWidth(context) * 0.35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants().secondaryColor,
                                    elevation: 0,
                                   
                                    shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Meet Again",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
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
}