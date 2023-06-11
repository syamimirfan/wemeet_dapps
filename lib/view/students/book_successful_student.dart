import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:gif/gif.dart';

class BookSuccessful extends StatefulWidget {
  
  final String lecturerName;
  final int numberOfStudents;
  final String date;
  final String time;

  BookSuccessful({Key? key, required this.lecturerName, required this.numberOfStudents, required this.date, required this.time}) : super(key: key);

  @override
  State<BookSuccessful> createState() => _BookSuccessfulState(this.lecturerName,  this.numberOfStudents,  this.date,  this.time);
}

class _BookSuccessfulState extends State<BookSuccessful> {
  _BookSuccessfulState(this.lecturerName, this.numberOfStudents, this.date, this.time);
  
  String lecturerName;
  int numberOfStudents;
  String date;
  String time;

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
       appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
          ),
    
          body: Padding(
            padding:Device.screenType == ScreenType.tablet? 
                     EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
                    EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding:Device.screenType == ScreenType.tablet? 
                      EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.17, horizontal: deviceWidth(context) * 0.06):
                      EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.09, horizontal: deviceWidth(context) * 0.06),
                decoration:  const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                           BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)
                        )
                  ),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Gif(
                          image: AssetImage("assets/success.gif"),
                          autostart: Autostart.once,
                          height: 150,
                        
                         duration: const Duration(seconds: 3),
                        ),
                        Text(
                        "Booking Successful",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: Device.screenType == ScreenType.tablet? 20:23,
                          fontWeight: FontWeight.bold,
                        ),
                       ),
                       SizedBox(height: 5,),
                            Text(
                        "You have successfully book your appointment",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: Device.screenType == ScreenType.tablet? 18:15,
                          fontWeight: FontWeight.w400,
                        ),
                       ),
                          SizedBox(height: 20,),
                       Container(
                      padding:Device.screenType == ScreenType.tablet? 
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.15,vertical: deviceHeight(context) * 0.1):
                      EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.09,vertical: deviceHeight(context) * 0.06),
                      height: deviceHeight(context) * 0.45,
                      width: deviceWidth(context) * 0.9,
                        decoration:   BoxDecoration(
                          color: Color(0xffC0C0C0),
                          borderRadius: BorderRadius.circular(10)
                           ),  
                          child: Column(
                
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              SizedBox(width: 20,),
                               Text(
                              "Your Appointment Details:",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: Device.screenType == ScreenType.tablet? 18:16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                                SizedBox(height: 10,),
                                   
                               Text(
                              lecturerName,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                                     SizedBox(height: 5,),
                               Text(
                              numberOfStudents.toString() + " students",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                                      SizedBox(height: 5,),
                              Text(
                              date ,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                               SizedBox(height: 5,),
                               Text(
                               time,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontWeight: FontWeight.bold,
                                color: Constants().secondaryColor,
                              ),
                            ),
                              SizedBox(height: 5.h),       
                     Flexible(
                       child: SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constants().secondaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                                 
                            ),
                                         
                          onPressed: () async{
                            nextScreenRemoveUntil(context, HomeStudents());
                          },
                           child:   Flexible(
                             child: Text(
                               "Confirm",
                               style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                               ),
                             ),
                           ),
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