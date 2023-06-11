import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
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
  
  String lectName = "";

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
    drawer: MainDrawerStudent(home: true, profile: false, book: false, appointment: false, reward: false, chat: false, yourHistory: false),
         
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
                      fontWeight: FontWeight.w400
                     ),
                  ),
                    ]),
                    ),
                  ),
                       
                   Padding(
                    padding:  Device.screenType == ScreenType.tablet? 
                     EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,):
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
                                    15:12,  
                         fontWeight: FontWeight.bold,
                         fontFamily: 'Poppins',
                           ),
                         ),
                       ),
                        SizedBox(width: deviceWidth(context) * 0.07,),
                          Icon(Icons.waving_hand, color: const Color(0xFFFFDD67)),
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
                       height: Device.screenType == ScreenType.tablet?  deviceHeight(context) * 100: deviceHeight(context) * 100,
                       width: Device.screenType == ScreenType.tablet?  deviceWidth(context) * 3: deviceWidth(context) * 3, 
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
                                          radius: Device.screenType == ScreenType.tablet? 70 : 40,
                                          backgroundImage: NetworkImage(lecturer['lecturerImage']),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          margin:  Device.screenType == ScreenType.tablet? 
                                                   EdgeInsets.only(left: deviceWidth(context) * 0.03, top: deviceHeight(context) * 0.02):
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
                                                                  20:14,
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
                                                  lecturer['lecturerName'],
                                                  style:TextStyle(
                                                      fontSize: Device.screenType == ScreenType.tablet? 
                                                                  19:14,
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
                                                                19:14,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                  ),
                                                ),
                                              ),  
                                                
                                                Container(
                                                  margin:  Device.screenType == ScreenType.tablet? 
                                                    EdgeInsets.only(top: 10, left: deviceWidth(context) * 0.55):
                                                    EdgeInsets.only(top: 20, left: deviceWidth(context) * 0.35),
                                                  child: Text.rich(
                                                    TextSpan(
                                                      text: "See More",
                                                          style:  TextStyle(
                                                              color: Constants().secondaryColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Poppins',
                                                              decoration: TextDecoration.underline,
                                                              fontSize: Device.screenType == ScreenType.tablet? 19:14,
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
                                      margin: Device.screenType == ScreenType.tablet? EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.3) : EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.2),
                                      child: Text(
                                        "Sorry, No Lecturer",
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