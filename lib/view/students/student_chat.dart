import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/view/students/student_message.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class StudentChat extends StatefulWidget {
  const StudentChat({super.key});

  @override
  State<StudentChat> createState() => _StudentChatState();
}

class _StudentChatState extends State<StudentChat> {

  List<dynamic> lecturers = [];
  List<dynamic> filterLecturers = [];
  String noData = "";

  String lectName = "";
  
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final TextEditingController _searchController = TextEditingController();
  
 @override
  void initState() {
    super.initState();

    getLecturerChat();
    getMatricNo();
  }

  
  getMatricNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var matricNo = _sharedPreferences.getString('matricNo');
    getMessage(matricNo);
    getManageAppointment(matricNo);
  }


  Widget buildChat() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03),
        child: ListView.builder(
        itemCount:_searchController.text.isNotEmpty ? filterLecturers.length : lecturers.length,
        itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: deviceHeight(context) * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(_searchController.text.isNotEmpty ? filterLecturers[index]['lecturerImage']: lecturers[index]['lecturerImage']),
                    ),
                     title:  Text(
                        _searchController.text.isNotEmpty ? filterLecturers[index]['lecturerName']:lecturers[index]['lecturerName'],
                        style:  TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Device.screenType == ScreenType.tablet?  18:18,
                          fontFamily: "Poppins"
                        ),
                      ),
                      onTap: () {
                        nextScreen(context, Message(staffNo: _searchController.text.isNotEmpty ? filterLecturers[index]['staffNo']:  lecturers[index]['staffNo']));
                      },
                  ), 
                ],
              ),
           );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:  const Text(
            "Chat",
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

        drawer: MainDrawerStudent(home: false, profile: false, book: false, appointment: false, reward: false, chat: true, yourHistory: false),

        body: Padding(
          padding: Device.screenType == ScreenType.tablet? 
                   EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
                   EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for search and filter the chat
                    Container(
                      padding: Device.screenType == ScreenType.tablet ? 
                               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.04):
                               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.04),
                     child: Form(
                        child: TextFormField(
                        decoration: inputTextDecorationSearch.copyWith(
                          hintText: "Search",
                          fillColor: Colors.white,
                          prefixIcon:Icon(Icons.search,color: Colors.grey,),
                        ),
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                                filterLecturers = lecturers.where((list) => list['lecturerName'].toLowerCase().contains(value.toLowerCase())).toList();
                          });
                        },
                      ),
                    ),
                  ),
                    SizedBox(height:deviceHeight(context) * 1, child: buildChat(),),
                ],
              ),
             ),
          ),
        ),
    );
  }

   //function to get lecturer chat
  getLecturerChat() async {
    final responseChat = await Chat().getChatStudents();
    if(responseChat['success']) {
      final responseData = responseChat['chat'];
      if(responseData is List) {
        setState(() {
          lecturers = responseData;
        });
      }else {
        setState(() {
          noData = responseChat['message'];
        });
       print("Error fetching data: ${responseChat['message']}");
      }
    }
  }

  //to get notification message from lecturer
   getMessage(String? matricNo) async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     String? staffNo = _sharedPreferences.getString("staffNumber");
     var responseChat = await new Chat().getUserMessage(matricNo!, staffNo!);
     if(responseChat['success']){
       final responseData = responseChat['chat'];
       if(responseData is List) {
         setState(() {
        bool lastMessageSentByLecturer = responseData.isNotEmpty && responseData.last['statusMessage'] == 2;
        if (lastMessageSentByLecturer && _sharedPreferences.getString("lecturerName") != "" && _sharedPreferences.getString("staffNumber") != "") {
             var lecturerName = _sharedPreferences.getString("lecturerName");
              NotificationService().showNotification(
              title: 'New message from Dr $lecturerName',
              body: responseData.last['messageText']).then((value) => {
                 _sharedPreferences.remove("lecturerName"),
                 _sharedPreferences.remove("staffNumber")
              });
           }
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
     }
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
          bool currentAcceptedAppointment = responseData.isNotEmpty && responseData.last['statusBooking'] == "Accepted";
          bool currentRejectedAppointment = responseData.isNotEmpty && responseData.last['statusBooking'] == "Rejected";
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
       if(_sharedPreferences.getInt("appointmentCancel") == 1 && _sharedPreferences.getString("appointmentCancelStaffNo") != ""){
            viewLecturer(_sharedPreferences.getString("appointmentCancelStaffNo")).then((value) => {
              NotificationService()
            .showNotification(title: "Appointment Cancelled!" ,body: lectName + " has cancel your appointment").then((value) => {
              _sharedPreferences.remove("appointmentCancel"),
              _sharedPreferences.remove("appointmentCancelStaffNo")
             })
            });
            
          }
       print("Error fetching data: ${responseBooking['message']}");
      }
    }
  }

}