// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/view/lecturers/appointment.dart';
import 'package:wemeet_dapps/view/lecturers/attendance.dart';
import 'package:wemeet_dapps/view/lecturers/home_lecturers.dart';
import 'package:wemeet_dapps/view/lecturers/lecturer_chat.dart';
import 'package:wemeet_dapps/view/lecturers/lecturer_profile.dart';
import 'package:wemeet_dapps/view/lecturers/slot.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class MainDrawerLecturer extends StatefulWidget {
   MainDrawerLecturer({ 
     Key? key,
    required this.home,
    required this.profile,
    required this.slot,
    required this.appointment,
    required this.attendance,
    required this.chat,
  }) : super(key: key);

  bool home;
  bool profile;
  bool slot;
  bool appointment;
  bool attendance;
  bool chat;

  @override
  State<MainDrawerLecturer> createState() => _MainDrawerLecturerState(
      this.home,
      this.profile,
      this.slot,
      this.appointment,
      this.attendance,
      this.chat,
  );
}

class _MainDrawerLecturerState extends State<MainDrawerLecturer> {
  _MainDrawerLecturerState( 
    this.home,
    this.profile,
    this.slot,
    this.appointment,
    this.attendance,
    this.chat,
    );
  bool home;
  bool profile;
  bool slot;
  bool appointment;
  bool attendance;
  bool chat;
  
  String staffNumber = "";
  String lectName = "";
  String lectImage = "";

  @override
 void initState() {
    //implement initState
    super.initState();

    getStaffNo();
  }
  
  //method to call the view student
  //WE CANNOT MAKE ASYNC IN void InitState() for some reason
  Future<void> getStaffNo() async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     viewLecturer(_sharedPreferences.getString('staffNo'));
  }
  

  @override
  Widget build(BuildContext context) {
    return Drawer(    
         child: ListView(
          padding:  const EdgeInsets.symmetric(vertical: 0),
          children: [
           Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          height: Device.screenType == ScreenType.tablet ? 300 : 230,
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:  EdgeInsets.only(bottom: 2.0.h),
              height: 10.0.h,
              
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                 border: Border.all(
                  width: 5,
                  color: Constants().secondaryColor,
                 ),
                image:   DecorationImage(
                       image: NetworkImage(lectImage),
                      ),
              ),
            ),
  

           Text(
            staffNumber,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22,fontFamily: 'Poppins',),
          ),
          const SizedBox(height:10),

          Flexible(
            child: Container(
             child:  Text(
            lectName,
             style: TextStyle(
               color: Colors.white,
               fontSize: 13,
               fontFamily: 'Poppins',
             ),
            ),
          )),

             ],
             
            ),
            
           ),
         
           ListTile(
            onTap: () {
              nextScreen(context, HomeLecturer());
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical:5),
            leading: const Icon(Icons.home, size: 30,),
            selectedTileColor: home == true? Constants().secondaryColor:Colors.white,
            selectedColor: home == true? Colors.white:Constants().secondaryColor,
            selected: home == true? true:false,
            title: Text(
              "Home",
              style: TextStyle(
                color: home == true? Colors.white: Colors.black,
                fontWeight: FontWeight.bold,
               fontSize: 20,
               fontFamily: 'Poppins',
              ),
            ),
           ),
           ListTile(
            onTap: () {
                nextScreen(context, LecturerProfile());
            },
            contentPadding: const EdgeInsets.symmetric(horizontal:20, vertical: 5),
            leading: const Icon(Icons.account_circle_rounded,size: 30,),
            selectedTileColor: profile == true? Constants().secondaryColor:Colors.white,
            selectedColor: profile == true? Colors.white:Constants().secondaryColor,
            selected: profile == true? true:false,
            title:  Text(
              "Profile",
              style: TextStyle(
                color: profile == true? Colors.white:Colors.black, 
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
           ),
           ListTile(
             onTap: () {
                nextScreen(context, Slot());
             }, 
             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             leading: const Icon(Icons.access_time_filled, size: 30,),
             selectedTileColor: slot == true? Constants().secondaryColor:Colors.white,
             selectedColor: slot == true? Colors.white:Constants().secondaryColor,
             selected: slot == true? true:false,
             title:  Text(
              "Slot",
              style: TextStyle(
                color: slot == true?Colors.white:Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
             ),
           ),
               ListTile(
             onTap: () {
                nextScreen(context, Appointment());
             }, 
             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             leading: const Icon(Icons.calendar_month_sharp, size: 30,),
             selectedTileColor: appointment == true? Constants().secondaryColor:Colors.white,
             selectedColor: appointment == true? Colors.white:Constants().secondaryColor,
             selected: appointment == true? true:false,
             title:  Text(
              "Appointment",
              style: TextStyle(
                 color: appointment == true?Colors.white:Colors.black,
                 fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
             ),
           ),
            ListTile(
             onTap: () {
               nextScreen(context, AttendanceAppointment());
             }, 
             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             leading: const Icon(Icons.class_rounded , size: 30,),
             selectedTileColor: attendance == true? Constants().secondaryColor:Colors.white,
             selectedColor: attendance == true? Colors.white:Constants().secondaryColor,
             selected: attendance == true? true:false,
             title:  Text(
              "Attendance",
              style: TextStyle(
                 color: attendance == true?Colors.white:Colors.black,
                 fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
             ),
           ),
            ListTile(
             onTap: () {
                 nextScreen(context, LecturerChat());
             }, 
             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             leading: const Icon(Icons.chat_rounded, size: 30,),
             selectedTileColor: chat == true? Constants().secondaryColor:Colors.white,
             selectedColor: chat == true? Colors.white:Constants().secondaryColor,
             selected: chat == true? true:false,
             title:  Text(
              "Chat",
              style: TextStyle(
                color: chat == true? Colors.white:Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
             ),
           ),
             ListTile(
             onTap: ()  {
              showDialog(
                barrierDismissible: false,
                context: context, 
                builder: (context) {
                  return  AlertDialog(
                    title:  const Text("Logout",  
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                      ),
                     ),
                    content: const Text("Are you sure you want to logout?",
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
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
                         final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                        _sharedPreferences.remove('staffNo');
                        _sharedPreferences.remove('statusLecturer');
                        print("LOGOUT!");
                        nextScreenReplacement(context, Login());
                      }, 
                      icon: const Icon(Icons.done, color: Colors.green,size: 30,)),
                    ],
                  );
                }
              );
        
             }, 
             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             leading: const Icon(Icons.exit_to_app,size: 30,),
             title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,     
                fontFamily: 'Poppins',
              ),
             ),
           ),
          ],
        ),
    );
  }

  
   viewLecturer(String? staffNo) async {
      var responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
  
      if(responseLecturer['success']) {
         setState(()  {
           lectImage =  responseLecturer['lecturer'][0]['lecturerImage'];
           staffNumber = responseLecturer['lecturer'][0]['staffNo'];
           lectName = responseLecturer['lecturer'][0]['lecturerName'];
         });
         print(lectImage);
      } else {
         throw Exception("Failed to get the data");
      }
 
  }

}