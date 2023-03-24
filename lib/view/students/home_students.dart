import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/lecturer_information.dart';

import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';


class HomeStudents extends StatefulWidget {
  const HomeStudents({super.key});

  @override
  State<HomeStudents> createState() => _HomeStudentsState();
}

class _HomeStudentsState extends State<HomeStudents> {
   
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;

  String studentName = "";
  List<dynamic> lecturer = [];
  String noData = "";

  @override
  void initState() {
    super.initState();

    getMatricNo();
    getLecturerInformation();
  }

  getMatricNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var matricNo = _sharedPreferences.getString('matricNo');
    getStudent(matricNo);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
drawer: MainDrawerStudent(home: true, profile: false, book: false, appointment: false, reward: false, chat: false, yourHistory: false),
       
       body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Padding(
                  padding: Device.screenType == ScreenType.tablet?  
                    const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
                              0.20.dp:0.32.dp,
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
                      studentName,
                       style: TextStyle(
                       color: Colors.white,
                       fontSize:  Device.screenType == ScreenType.tablet?  
                                  0.18.dp: 0.26.dp,  
                       fontWeight: FontWeight.bold,
                       fontFamily: 'Poppins',
                         ),
                       ),
                     ),
                      SizedBox(width: deviceWidth(context) * 0.07,),
                        Icon(Icons.waving_hand, color: const Color(0xFFFFDD67), size:Device.screenType == ScreenType.tablet?  0.2.dp: 0.4.dp,),
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
                               0.30.dp:0.40.dp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                   ),
                ),
                  ]),
                  ),
                ),
            
                const SizedBox(height: 30,),
                
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
                     height: Device.screenType == ScreenType.tablet?  849: deviceHeight(context) * 100,
                     width: Device.screenType == ScreenType.tablet?  1000: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: const EdgeInsets.only(top: 20,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                               const Text(
                                "Lecturer Information",
                               style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                               ),
                              ),
                               Column(
                                children: lecturer.map((lecturer) => 
                                  Container(
                                margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
                                padding: const EdgeInsets.all(15),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:  const EdgeInsets.only(left: 5),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(lecturer['lecturerImage']),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin:  Device.screenType == ScreenType.tablet? 
                                                const EdgeInsets.only(left: 20):
                                                EdgeInsets.only(left: deviceWidth(context) * 0.03, top: deviceHeight(context) * 0.02),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(top: deviceHeight(context) * 0.01),
                                              child: Text(
                                              lecturer['staffNo'] ,
                                                style: TextStyle(
                                                    fontSize:  Device.screenType == ScreenType.tablet? 
                                                                0.18.dp: 0.30.dp,
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
                                                lecturer['lecturerName'],
                                                style:TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                                0.18.dp: 0.28.dp,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                              child: Text(
                                               lecturer['lecturerTelephoneNo'],
                                                style: TextStyle(
                                                    fontSize: Device.screenType == ScreenType.tablet? 
                                                                0.18.dp: 0.26.dp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                ),
                                              ),
                                            ),  
                                              
                                              Container(
                                                margin:  Device.screenType == ScreenType.tablet? 
                                                const  EdgeInsets.only(top: 10, left:520):
                                                  EdgeInsets.only(top: 20, left: deviceWidth(context) * 0.35),
                                                child: Text.rich(
                                                  TextSpan(
                                                    text: "See More",
                                                        style:  TextStyle(
                                                            color: Constants().secondaryColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Poppins',
                                                            decoration: TextDecoration.underline,
                                                            fontSize: 13,
                                                        ),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                           nextScreen(context, LecturerInformation(staffNo: lecturer['staffNo'],));
                                                
                                                        }
                                                  ),
                                                ),
                                              ),
                                  
                                          ],
                                        ),
                                        
                                        ),
                                    ),
                                    
                                  ],
                                ),
                            )
                                ).toList(),
                               ),
                               SizedBox(height: deviceHeight(context) * 0.03,),
                                //if no lecturer
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  noData == "Empty Data" ?
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.2),
                                    child: Text(
                                      "Sorry, No Lecturer",
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
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ],
             ),
           ),
    );
  }


  //get student name at homepage
  getStudent(String? matricNo) async {
    final responseStudent = await new Student().getStudentDetail(matricNo!);

    if(responseStudent['success']) {
     setState(() {
       studentName = responseStudent['student'][0]['studName'];
     });
    }
  }

  //get all lecturer in lecturer information
  getLecturerInformation() async {
    final responseStudent = await new Student().getLecturer();
    if(responseStudent['success']){
      final responseData = responseStudent['lecturer'];
      if(responseData is List){
        setState(() {
          lecturer = responseData;
        });
      }else {
        setState(() {
          noData = responseStudent['message'];
        });
        print(responseStudent['message']);
      }
    }
  }
}