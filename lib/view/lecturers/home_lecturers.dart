import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';


class HomeLecturer extends StatefulWidget {
  const HomeLecturer({super.key});

  @override
  State<HomeLecturer> createState() => _HomeLecturerState();
}

class _HomeLecturerState extends State<HomeLecturer> {
  List<dynamic> appointment = [];
  String lectName = "";
  String noData = "";
  String studentName = "";
  String studentNameBookingUpdate = "";

  @override
  void initState() { 
    super.initState();
    
    getStaffNo();
}

  getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var staffNo = _sharedPreferences.getString('staffNo');
    getLecturer(staffNo);
    getAppointment(staffNo);
  }

  @override
  Widget build(BuildContext context) {
      double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
      double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                         EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,):
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
                                18:18,
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
                          lectName,
                         style: TextStyle(
                         color: Colors.white,
                         fontSize:  Device.screenType == ScreenType.tablet?  
                                    15:12,  
                         fontWeight: FontWeight.bold,
                         fontFamily: 'Poppins',
                           ),
                         ),
                       ),
                        SizedBox(width: deviceWidth(context) * 0.07,),
                          Icon(Icons.waving_hand, color: const Color(0xFFFFDD67),),
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
                                 30:23,
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
                       height: Device.screenType == ScreenType.tablet ?  deviceHeight(context) * 3: deviceHeight(context) * 3,
                       width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 3: deviceWidth(context) * 3, 
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
      
                  
                                Column(
                                   children: appointment.where((booking) => booking['statusBooking'] == "Appending").map((booking)=> 
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
                                                radius: Device.screenType == ScreenType.tablet? 70 : 60,
                                                backgroundImage: NetworkImage(booking['studImage']),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              margin:  Device.screenType == ScreenType.tablet? 
                                              EdgeInsets.only(left: deviceWidth(context) * 0.05, top: deviceHeight(context) * 0.02):
                                              EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                         Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['matricNo'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                                20:14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                ),
                                              ),
                                            ),
                                             Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                               EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['studName'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                                19:14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                ),
                                              ),
                                            ),
                                             Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                                 EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['studTelephoneNo'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                                 19:14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                ),
                                              ),
                                            ),
                                             Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                                 EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['numberOfStudents'].toString() + " students",
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                              19:14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                 ),
                                                 ),
                                            Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                                 EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['date'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                              19:14,
                                                    fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                 ),
                                                 ),
                                            Container(
                                              margin: Device.screenType == ScreenType.tablet? 
                                                 EdgeInsets.only(bottom: deviceWidth(context) * 0.001):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Text(
                                                booking['time'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                              19:14,
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
                               SizedBox(height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.01 : deviceHeight(context) * 0.01,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                             height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.04 : deviceHeight(context) * 0.04,
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
                                          showConfirmationRejectBox(context, "Confirm?", "Are you sure to reject this session?",booking['bookingId']);
                                        },
                                        child:  Text(
                                          "Reject",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                              fontFamily: 'Poppins',
                                          ),
                                        ),
                                    ),
                                  ),
                                    SizedBox(
                                       height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.04 : deviceHeight(context) * 0.04,
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
                                          showConfirmationAcceptBox(context, "Confirm?", "Are you sure to accept this session?", booking['bookingId']);
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                              fontFamily: 'Poppins',
                                          ),
                                        ),
                                          ),
                                        ),
                                        ],
                                      ),
                                 SizedBox(height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.01 : deviceHeight(context) * 0.01,),
                                        ],
                                      ),
                                    ),
                                   ).toList(),
                                   
                                ),
    
                                //if no appointment request
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    noData == "Empty Data" ?
                                    Container(
                                      margin: Device.screenType == ScreenType.tablet? EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.3) : EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.2),
                                      child: Text(
                                        "Sorry, No Appointment",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: Device.screenType == ScreenType.tablet? 18:14,
                                          fontWeight: FontWeight.w600,
                                          color: Constants().secondaryColor
                                        ),
                                      ),
                                    ):Center(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
               ),
             ),
      ),
    );
  }
    //message to confirmation of action for reject request from the lecturer
  void showConfirmationRejectBox(BuildContext context, String title, String message,int bookingId) {
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
          IconButton(onPressed: () {
            reject(bookingId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }

    //message to confirmation of action for accept request from the lecturer
    //MAKE SURE TO REMOVE THE APPOINTMENT THAT HAS BEEN ACCEPTED FROM THE UI
    void showConfirmationAcceptBox(BuildContext context, String title, String message, int bookingId) {
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
            accept(bookingId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }

  //get lecturer name at homepage
  getLecturer(String? staffNo) async {
    final responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
     if(responseLecturer['success']){
       setState(() {
         lectName = responseLecturer['lecturer'][0]['lecturerName'];
       });
     }
  }

  //to view some of student data
    viewStudent(String? matricNo) async {
      var responseStudent = await new Student().getStudentDetail(matricNo!);
      if(responseStudent['success']) {
         setState(()  {
           studentName = responseStudent['student'][0]['studName'];
         });
      } else {
         throw Exception("Failed to get the data");
      }
 
  }

   //get all appointment in lecturer
  getAppointment(String? staffNo) async {
    final responseBooking = await new Booking().getAppointmentRequest(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          appointment = responseData;
        });
      }else {
        setState(() {
          noData = responseBooking['message'];
        });
        print(responseBooking['message']);
      }
    }
  }

  
  //to view some of student data
    viewStudentBookingUpdate(String? matricNo) async {
      var responseStudent = await new Student().getStudentDetail(matricNo!);
      if(responseStudent['success']) {
         setState(()  {
           studentNameBookingUpdate = responseStudent['student'][0]['studName'];
         });
      } else {
         throw Exception("Failed to get the data");
      }
   }

  
  //reject the appointment request
  reject(int bookingId) async {
    final responseBooking = await new Booking().rejectAppointmentRequests(bookingId);
    if(responseBooking['success']){
      nextScreenReplacement(context, HomeLecturer());
    }else {
      throw Exception(responseBooking['message']);
    }
  }

   //accept the appointment request
  accept(int bookingId) async {
    final responseBooking = await new Booking().acceptAppointmentRequests(bookingId);
    if(responseBooking['success']){
      print(lectName);
      nextScreenReplacement(context, HomeLecturer());
    }else {
      throw Exception(responseBooking['message']);
    }
  }

   //to make user exit the app if the press back button in the phone
 //use WillPopScope and wrap in Scaffold widget
  Future<bool> _onWillPop() async {
    return  (
      await showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (context) {
                    return  AlertDialog(
                      title:  const Text("Exit App",  
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                        ),
                       ),
                      content: const Text("Do you want exit WeMeet?",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            ),
                       ),
                      actions: [
                        IconButton(
                          onPressed: () {
                         nextScreenPop(context);
                        },
                         icon: const Icon(Icons.cancel,color: Colors.red,size: 30,),
                         ),
                        IconButton(onPressed: () async{
                              Navigator.of(context).pop(true);
                              SystemNavigator.pop();
                        }, 
                        icon: const Icon(Icons.done, color: Colors.green,size: 30,)),
                      ],
                    );
                  }
          ));
      }

}