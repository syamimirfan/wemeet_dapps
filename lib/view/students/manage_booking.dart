import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/student_message.dart';
import 'package:wemeet_dapps/view/students/update_book.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({super.key});

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  List<dynamic> appointment = [];
  String noData = "";
  String lectName = "";

  @override
  void initState() {
    super.initState();

    getMatricNo();
  }

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  getMatricNo() async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     var matricNo = _sharedPreferences.getString('matricNo');
     getManageAppointment(matricNo);
  }

  //to view some of lecturer data  
   viewLecturer(String? staffNo) async {
      var responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
  
      if(responseLecturer['success']) {
         setState(()  {
           lectName = responseLecturer['lecturer'][0]['lecturerName'];
           
         });
      } else {
         throw Exception("Failed to get the data");
      }
 
  }

  //function to get appointment
  getManageAppointment(String? matricNo) async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final responseBooking = await Booking().manageAppointmentStudent(matricNo!);
    if(responseBooking['success']) {
      final responseData = responseBooking['booking'];
      if(responseData is List) {
        setState(() {
          appointment = responseData;
          bool currentAcceptedAppointment = appointment.isNotEmpty && appointment.last['statusBooking'] == "Accepted";
          bool currentRejectedAppointment = appointment.isNotEmpty && appointment.last['statusBooking'] == "Rejected";
          if(currentAcceptedAppointment && _sharedPreferences.getInt("acceptAppointment") == 1 && _sharedPreferences.getString("acceptAppointmentLectName") != ""){
             NotificationService()
            .showNotification(title: "Congratulations! You're set" ,body:  _sharedPreferences.getString("acceptAppointmentLectName")! + " has accept your appointment").then((value) => {
                _sharedPreferences.remove("acceptAppointment"),
                _sharedPreferences.remove("acceptAppointmentLectName"),
            });
          }else if (currentRejectedAppointment && _sharedPreferences.getInt("rejectAppointment") == 2 && _sharedPreferences.getString("rejectAppointmentLectName") != "") {
            NotificationService()
            .showNotification(title: "Sorry, You're not set" ,body: _sharedPreferences.getString("rejectAppointmentLectName")! + " has reject your appointment").then((value) => {
               _sharedPreferences.remove("rejectAppointment"),
               _sharedPreferences.remove("rejectAppointmentLectName"),
            });
          }else if(_sharedPreferences.getInt("appointmentCancel") == 1 && _sharedPreferences.getString("appointmentCancelStaffNo") != ""){
            viewLecturer(_sharedPreferences.getString("appointmentCancelStaffNo")).then((value) => {
              NotificationService()
            .showNotification(title: "Appointment Cancelled!" ,body: lectName + " has cancel your appointment").then((value) => {
              _sharedPreferences.remove("appointmentCancel"),
              _sharedPreferences.remove("appointmentCancelStaffNo")
             })
            });
            
          }
        });
      }else {
        setState(() {
          noData = responseBooking['message'];
        });
       print("Error fetching data: ${responseBooking['message']}");
      }
    }
  }

  //funtion to delete rejected appointment
  deleteRejectedAppointment(int bookingId) async {
     var responseBooking = await new Booking().deleteAppointment(bookingId);
     if(responseBooking['success']){
        showMessage(context, "Appointment Deleted", "The rejected appointment has been deleted. Please book your appointment again to continue meet with your lecturer", "Ok");
     }else {
       throw Exception(responseBooking['message']);
     }
  }

    //show message box function
  void showMessage(BuildContext context, String title, String message, String buttonText) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
           content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
           actions: [ 
              ElevatedButton(
                onPressed: () {
                 nextScreenReplacement(context, ManageBooking());
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().secondaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
  }

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
      drawer: MainDrawerStudent(home: false, profile: false, book: false, appointment: true, reward: false, chat: false, yourHistory: false),

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
                   children: [
                     Column(
                      children: appointment.map((appointment) =>          
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
                         child:Column(
                          children: [
                            //for status booking
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                    "Status: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    appointment['statusBooking'],
                                    style: TextStyle(
                                     color:  appointment['statusBooking'] == "Accepted" ? Constants().acceptedColor :  appointment['statusBooking'] == "Appending" ? Constants().primaryColor : appointment['statusBooking'] == "Rejected" ? Constants().secondaryColor : Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              ],
                          ),
                            ),

                            //for booking information
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                //for lecturer images
                                  Container(
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(appointment['lecturerImage']),
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
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01,
                                                right: deviceWidth(context) * 0.01,
                                              ) ,
                                            child: Text(
                                              appointment['lecturerName'],
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
                                                appointment['numberOfStudents'].toString() + " Student",
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
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.008) ,
                                            child: Text(
                                                appointment['date'],
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
                                               appointment['time'],
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
                      appointment['statusBooking'] != "Rejected" ?  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        nextScreen(context, Message(staffNo: appointment['staffNo']));
                                      },
                                      child: const Text(
                                        "Contact Lecturer",
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
                               
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().quaternaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                         nextScreen(context, UpdateBook(staffNo: appointment['staffNo'],bookingId: appointment['bookingId'],));
                                      },
                                      child: const Text(
                                        "Update",
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
                            ) : Container(
                              margin: EdgeInsets.only(left: deviceWidth(context) * 0.6),
                              child: Row(
                                children: [
                                   SizedBox(
                                     child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Constants().secondaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          deleteRejectedAppointment(appointment['bookingId']);
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
                            ),
                          ],
                         ) ,
                     ),
                   
                     ).toList(),
                     ),
                     //if no appointment
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  noData == "Empty Data" ?
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.4),
                                    child: Text(
                                      "Sorry, No Appointment",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Constants().secondaryColor
                                      ),
                                    ),
                                  ):Center(),
                                ],
                              )
                   ]
                            
                ),
            ),
        ),
      ),
    );
  }
}
