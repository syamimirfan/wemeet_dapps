import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_attendance.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class AttendanceAppointment extends StatefulWidget {
  const AttendanceAppointment({super.key});

  @override
  State<AttendanceAppointment> createState() => _AttendanceAppointmentState();
}

class _AttendanceAppointmentState extends State<AttendanceAppointment> {

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  List<dynamic> acceptedAppointments = [];
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
    getAttendance(staffNo);
    getMessage(staffNo);
    getAppointment(staffNo);
    getAppointmentUpdated(staffNo);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
            "Attendance",
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
    drawer: MainDrawerLecturer(home: false, profile: false, slot: false, appointment: false, attendance: true, chat: false),
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
                child: Column(
                  children: [
                    Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                     children: acceptedAppointments.where((booking) => booking['statusBooking'] == "Accepted")
                    .map((booking) => 
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
                                          backgroundColor: Constants().secondaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async{
                            final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                                  var staffNo = _sharedPreferences.getString('staffNo');
                                        showConfirmationAbsentBox(context, "Confirm?", "Are you sure to sign absent for this session?",booking['matricNo'],staffNo!,booking['numberOfStudents'],booking['date'], booking['time'], booking['bookingId']);
                                        },
                                        child: Text(
                                          "Absent",
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
                                          backgroundColor: Constants().primaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async{
                                        final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                                         var staffNo = _sharedPreferences.getString('staffNo');
                                        showConfirmationAttendBox(context, "Confirm?", "Are you sure to sign attend for this session?",booking['matricNo'],staffNo!,booking['numberOfStudents'],booking['date'], booking['time'], booking['bookingId']);
                                        },
                                        child: Text(
                                          "Attend",
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
                  ],
                ),
            ),
        ),
      ),
    );
  }

  //message to confirmation of action for attend meeting from the lecturer (INSERT to attendance table , DELETE the current data in booking table in database)
  void showConfirmationAttendBox(BuildContext context, String title, String message, String matricNo, String staffNo, int numberOfStudents, String date, String time, int bookingId) {
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
            attend(matricNo, staffNo, numberOfStudents, date, time, bookingId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }
    //message to confirmation of action for absent meeting from the lecturer (INSERT to attendance table , DELETE the current data in booking table in database)
   void showConfirmationAbsentBox(BuildContext context, String title, String message, String matricNo, String staffNo, int numberOfStudents, String date, String time, int bookingId) {
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
             absent(matricNo, staffNo, numberOfStudents, date, time, bookingId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }
  //function get all accepted appointment for manage appointment in lecturer
  getAttendance(String? staffNo) async {
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

  //function absent the appointment
  absent(String matricNo, String staffNo, int numberOfStudents, String date, String time, int bookingId) async{
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     var responseAttendance = await new Attendance().absentAttendance( matricNo,  staffNo,  numberOfStudents, date,  time);
     var responseBooking = await new Booking().deleteAppointment(bookingId);
     if(responseAttendance['success'] && responseBooking['success']){
       _sharedPreferences.setInt("studentAbsent", 1);
       _sharedPreferences.setString("lecturerAbsentStaffNo", staffNo);
       nextScreenReplacement(context, AttendanceAppointment());
     }else {
       throw Exception(responseAttendance['message'] + responseBooking['message']);
     }
  }

   //function absent the appointment
  attend(String matricNo, String staffNo, int numberOfStudents, String date, String time, int bookingId) async{
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     var responseAttendance = await new Attendance().attendAppointment( matricNo,  staffNo,  numberOfStudents, date,  time);
     var responseBooking = await new Booking().deleteAppointment(bookingId);
     if(responseAttendance['success'] && responseBooking['success']){
       _sharedPreferences.setInt("studentAttend", 1);
       _sharedPreferences.setString("lecturerAttendStaffNo", staffNo);
       nextScreenReplacement(context, AttendanceAppointment());
     }else {
       throw Exception(responseAttendance['message'] + responseBooking['message']);
     }
  }

    //to get notification message from student
   getMessage(String? staffNo) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String? matricNo = _sharedPreferences.getString("matricNumber");
     var responseChat = await new Chat().getUserMessage(matricNo!, staffNo!);
     if(responseChat['success']){
        final responseData = responseChat['chat'];
       if(responseData is List) {
         setState(() {
        bool lastMessageSentByStudent = responseData.isNotEmpty && responseData.last['statusMessage'] == 1;
        if (lastMessageSentByStudent && _sharedPreferences.getString("studentName") != "" && _sharedPreferences.getString("matricNumber") != "") {
           var studentName = _sharedPreferences.getString("studentName");
          NotificationService().showNotification(
              title: 'New message from $studentName',
              body: responseData.last['messageText']).then((value) => {
                 _sharedPreferences.remove("studentName"),
                 _sharedPreferences.remove("matricNumber")
              });
          }
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
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
      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final responseBooking = await new Booking().getAppointmentRequest(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          bool currentAppointmentRequested = responseData.isNotEmpty && responseData.last['statusBooking'] == "Appending";
          if(currentAppointmentRequested && _sharedPreferences.getInt("bookingAdd") == 1 && _sharedPreferences.getString("bookingAddMatricNumber") != ""){
           viewStudent(_sharedPreferences.getString("bookingAddMatricNumber")).then((value) => {
             NotificationService()
            .showNotification(title: "New Appointment" ,body: studentName + " has book an appointment session with you").then((value) => {
              _sharedPreferences.remove("bookingAdd"),
              _sharedPreferences.remove("bookingAddMatricNumber")
            })
           });
          }
        });
      }else {
  
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

   //get all accepted appointment for manage appointment in lecturer
  getAppointmentUpdated(String? staffNo) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final responseBooking = await new Booking().getAcceptedAppointment(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          if(_sharedPreferences.getInt("bookingUpdate") == 1 && _sharedPreferences.getString("bookingUpdateMatricNumber") != ""){
            viewStudentBookingUpdate(_sharedPreferences.getString("bookingUpdateMatricNumber")).then((value) => {
             NotificationService()
            .showNotification(title: "Appointment Updated!" ,body: studentNameBookingUpdate + " has update an appointment session with you").then((value) => {
              _sharedPreferences.remove("bookingUpdate"),
              _sharedPreferences.remove("bookingUpdateMatricNumber")
            })
           });
          }
        });
      }else {
        print(responseBooking['message']);
      }
    }
  }
}