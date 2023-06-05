import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/lecturers/lecturer_message.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  List<dynamic> acceptedAppointments = [];
  String noData = "";
  String appointmentCancelStaffNo = "";
  String studentName = "";

  @override
  void initState() {
    super.initState();

    getStaffNo();
  }

  getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var staffNo = _sharedPreferences.getString('staffNo');
    getAppointment(staffNo);
    setState(() {
      appointmentCancelStaffNo = staffNo!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                   EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
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
                  child: Expanded(
                    child: Column(
                      children: [ 
                        Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                         children:acceptedAppointments.where((booking) => booking['statusBooking'] == "Accepted").map((booking) =>
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
                                            radius: Device.screenType == ScreenType.tablet? 70 : 40,
                                            backgroundImage: NetworkImage(booking['studImage']),
                                          ),
                                        ),
                                        //for booking information
                                        Flexible(
                                          child: Container(
                                             margin:  Device.screenType == ScreenType.tablet? 
                                             EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02):
                                            EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                  margin: Device.screenType == ScreenType.tablet? 
                                                     EdgeInsets.only(bottom: deviceWidth(context) * 0.01):
                                                    EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                                  child: Text(
                                                    booking['studName'],
                                                    style:TextStyle(
                                                        fontSize: Device.screenType == ScreenType.tablet? 
                                                                  18:14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                 Container(
                                                  margin: Device.screenType == ScreenType.tablet? 
                                                     EdgeInsets.only(bottom: deviceWidth(context) * 0.01):
                                                    EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                                  child: Text(
                                                    booking['numberOfStudents'].toString() + " student",
                                                    style:TextStyle(
                                                        fontSize: Device.screenType == ScreenType.tablet? 
                                                                  18:14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                 Container(
                                                  margin: Device.screenType == ScreenType.tablet? 
                                                   EdgeInsets.only(bottom: deviceWidth(context) * 0.01):
                                                    EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                                  child: Text(
                                                    booking['date'],
                                                    style:TextStyle(
                                                        fontSize: Device.screenType == ScreenType.tablet? 
                                                                  18:14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                 Container(
                                                  margin: Device.screenType == ScreenType.tablet? 
                                                     EdgeInsets.only(bottom: deviceWidth(context) * 0.01):
                                                    EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                                  child: Text(
                                                    booking['time'],
                                                    style:TextStyle(
                                                        fontSize: Device.screenType == ScreenType.tablet? 
                                                                   18:14,
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
                           SizedBox(
                            height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.01 : deviceHeight(context) * 0.01,),
                                  //for button contact lecturer and update
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                          height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.04 : deviceHeight(context) * 0.04,
                                         child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Constants().primaryColor,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              nextScreen(context, LecturerMessage(matricNo: booking['matricNo']));
                                            },
                                            child: Text(
                                              "Contact Student",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: Device.screenType == ScreenType.tablet? 18:14,
                                                  fontFamily: 'Poppins',
                                              ),
                                            ),
                                        ),
                                      ),
                                         SizedBox(
                                            height:  Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.04 : deviceHeight(context) * 0.04,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Constants().secondaryColor,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                            showConfirmationDeleteBox(context, "Confirm?", "Delete Appointment. Please let your student know that you cannot proceed with the appointment.",booking['bookingId']);
                                            },
                                            child:  Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                 fontSize: Device.screenType == ScreenType.tablet? 18:14,
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
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               noData == "Empty Data" ?
                                Container(
                                 margin: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.4),
                                  child: Text(
                                  "Sorry, No Appointment",
                                   style: TextStyle(
                                   fontFamily: 'Poppins',
                                    fontSize: Device.screenType == ScreenType.tablet? 0.17.dp : 0.32.dp,
                                   fontWeight: FontWeight.w600,
                                   color: Constants().secondaryColor
                                     ),
                                  ),
                                ):Center(),
                              ]
                         ),
                      ]
                    ),
                  ),
              ),
          ),
        ),
      ),
    );
  }

  //message to confirmation of action for delete accepted from the lecturer (DELETE booking from the database)
  void showConfirmationDeleteBox(BuildContext context, String title, String message, int bookingId) {
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
             deleteAppointment(bookingId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
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



  //get all accepted appointment for manage appointment in lecturer
  getAppointment(String? staffNo) async {
    final responseBooking = await new Booking().getAcceptedAppointment(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          acceptedAppointments = responseData;
        });
      }else {
        setState(() {
          noData = responseBooking['message'];
        });
        print(responseBooking['message']);
      }
    }
  }

 //to cancel appointment between student
  deleteAppointment(int bookingId) async {
    var responseBooking = await new Booking().deleteAppointment(bookingId);
    
    if(responseBooking['success']) {
      nextScreenReplacement(context, Appointment());
    }else{
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