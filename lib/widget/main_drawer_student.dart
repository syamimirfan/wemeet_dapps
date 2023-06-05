// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/view/students/book1_student.dart';
import 'package:wemeet_dapps/view/students/history.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/view/students/manage_booking.dart';
import 'package:wemeet_dapps/view/students/reward.dart';
import 'package:wemeet_dapps/view/students/student_chat.dart';
import 'package:wemeet_dapps/view/students/student_profile.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

// ignore: must_be_immutable
class MainDrawerStudent extends StatefulWidget {
   MainDrawerStudent({
    Key? key,
    required this.home,
    required this.profile,
    required this.book,
    required this.appointment,
    required this.reward,
    required this.chat,
    required this.yourHistory,
  }) : super(key: key);

  bool reward;
  bool appointment;
  bool book;
  bool chat;
  bool home;
  bool profile;
  bool yourHistory;

  @override
  // ignore: no_logic_in_create_state
  State<MainDrawerStudent> createState() => _MainDrawerStudentState(
     this.home,
     this.profile,
     this.book,
     this.appointment,
     this.reward,
     this.chat,
     this.yourHistory,
  );
}

class _MainDrawerStudentState extends State<MainDrawerStudent> {
  _MainDrawerStudentState( 
    this.home,
    this.profile,
    this.book,
    this.appointment,
    this.reward,
    this.chat,
    this.yourHistory,
     );

  bool reward;
  bool appointment;
  bool book;
  bool chat;
  bool home;
  bool profile;
  bool yourHistory;

late String matricNumber = "";
late String studentName = "";
late String studentImage = "";
   
 @override
 void initState() {
    //implement initState
    super.initState();

    getMatricNo();
  }
  
  //method to call the view student
  //WE CANNOT MAKE ASYNC IN void InitState() for some reason
  Future<void> getMatricNo() async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     viewStudent(_sharedPreferences.getString('matricNo'));
  }
  
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Drawer(
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
                         image: NetworkImage(studentImage),
                        ),
                ),
              ),
        
      
             Text(
              matricNumber,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22,fontFamily: 'Poppins'),
            ),
            const SizedBox(height:10),
      
            Flexible(
              child: Container(
               child:  Text(
                textAlign: TextAlign.center,
              studentName,
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 12,
                 fontFamily: 'Poppins',
               ),
              ),
            )),
      
               ],
               
              ),
              
             ),
           
             ListTile(
              onTap: () {
                nextScreenRemoveUntil(context, HomeStudents());
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
                 nextScreenRemoveUntil(context, StudentProfile());
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
                  nextScreenRemoveUntil(context, Book());
               }, 
               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
               leading: const Icon(Icons.add_circle, size: 30,),
               selectedTileColor: book == true? Constants().secondaryColor:Colors.white,
               selectedColor: book == true? Colors.white:Constants().secondaryColor,
               selected: book == true? true:false,
               title:  Text(
                "Book",
                style: TextStyle(
                  color: book == true?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
               ),
             ),
                 ListTile(
               onTap: () {
                  nextScreenRemoveUntil(context, ManageBooking());
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
                  nextScreenRemoveUntil(context, RewardToken());
               }, 
               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
               leading: const Icon(Icons.token_sharp , size: 30,),
               selectedTileColor: reward == true? Constants().secondaryColor:Colors.white,
               selectedColor: reward == true? Colors.white:Constants().secondaryColor,
               selected: reward == true? true:false,
               title:  Text(
                "Reward",
                style: TextStyle(
                   color: reward == true?Colors.white:Colors.black,
                   fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
               ),
             ),
              ListTile(
               onTap: () {
                  nextScreenRemoveUntil(context, StudentChat());
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
               onTap: () {
                  nextScreenRemoveUntil(context, ManageHistory());
               }, 
               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
               leading: const Icon(Icons.history_sharp,size: 30,),
               selectedTileColor: yourHistory == true? Constants().secondaryColor:Colors.white,
               selectedColor: yourHistory == true? Colors.white:Constants().secondaryColor,
               selected: yourHistory == true? true:false,
               title: Text(
                "Your History",
                style: TextStyle(
                  color: yourHistory == true? Colors.white:Colors.black,
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
                          _sharedPreferences.remove('matricNo');
                           _sharedPreferences.remove('statusStudent');
                           _sharedPreferences.remove('tokenAddress');
                          print("LOGOUT!");
                          nextScreenRemoveUntil(context, Login());
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
          ),
      );
       
  }

  //to view some of student data
   viewStudent(String? matricNo) async {
      var responseStudent = await new Student().getStudentDetail(matricNo!);
  
      if(responseStudent['success']) {
         setState(()  {
           studentImage =  responseStudent['student'][0]['studImage'];
           matricNumber = responseStudent['student'][0]['matricNo'];
           studentName = responseStudent['student'][0]['studName'];
         });
         print(studentImage);
      } else {
         throw Exception("Failed to get the data");
      }
 
  }
}