import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_attendance.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/book2_student.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class ManageHistory extends StatefulWidget {
  const ManageHistory({super.key});

  @override
  State<ManageHistory> createState() => _ManageHistoryState();
}

class _ManageHistoryState extends State<ManageHistory> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  List<dynamic> attendance = [];
  String noData = "";

  @override
  void initState() {
    super.initState();  

    getMatricNo();
  }

  getMatricNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var matricNo = _sharedPreferences.getString("matricNo");

    getAllAttendance(matricNo);
  }

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
 
                children: [
                  Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.end,

                     children: attendance.map((attendance) => 
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
                              children: [
                            //for status attendance
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    attendance['status'],
                                    style: TextStyle(
                                     color:  attendance['status'] == "Attend" ? Constants().acceptedColor :  attendance['status'] == "Absent" ? Constants().secondaryColor : Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 35.w,),
                                  IconButton(
                                   onPressed: () {
             
                                   },
                                   icon: Icon(Icons.delete, size: 30, color: Constants().secondaryColor,)
                                  ),

                              ],
                             ),
                            ),
                          //for attendance information
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                //for lecturer images
                                  Container(
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(attendance['lecturerImage']),
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
                                              attendance['lecturerName'],
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
                                              attendance['numberOfStudents'].toString() + " Student",
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
                                              attendance['date'],
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
                                              attendance['time'],
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

                            Container(
            
                              child: Row(
                        
                                children: [
                                    Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "Token Gained: ",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                               0.16.dp: 0.26.dp,
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
                                             attendance['statusReward'] == "Not Send" ? "0 UTHM":
                                            attendance['statusReward'] == "Send" ? "1 UTHM" :
                                            "NO Token Send",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                               0.16.dp: 0.26.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: attendance['statusReward'] == "Not Send" ? Constants().secondaryColor: attendance['statusReward'] == "Send" ? Constants().primaryColor: Colors.black,
                                              ),
                                            ),
                                          ),
                                     SizedBox(width: 20.w,) ,
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
                                          nextScreen(context, Book2(staffNo: attendance['staffNo']));
                                        },
                                        child: const Text(
                                          "Meet Again",
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
                               fontSize: 20,
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
 
  //message confirmation to delete attendance   
  void deleteConfirmationBox(BuildContext context, String title, String message,int attendanceId) async{
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
            deleteSelectedAttendance(attendanceId);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }

  //get all attendance from accepted appointments
  getAllAttendance(String? matricNo) async {
     var responseAttendance = await new Attendance().getAttendance(matricNo!);
     if(responseAttendance['success']){
        final responseData = responseAttendance['attendance'];
        if(responseData is List) {
          setState(() {
            attendance = responseData;
          });
        }else{
          setState(() {
            noData = responseAttendance["message"];
          });
          throw Exception(responseAttendance['message']);
        }
     }
  }  

  //delete attendance
  deleteSelectedAttendance(int attendanceId) async {
     var responseAttendance = await new Attendance().deleteAttendance(attendanceId);
     if(responseAttendance['success']) {
        nextScreenReplacement(context, ManageHistory());
     }else{
        throw Exception(responseAttendance['message']);
     }
  }

}