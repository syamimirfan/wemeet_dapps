import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import '../../shared/constants.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  String studentImage = "";
  String studentName = "";
  String matricNumber = "";
  String icNumber = "";
  String studentTelephoneNumber = "";
  String studentEmail = "";
  String faculty = "";
  String program = "";
  String tokenAddress = "";

  String lectName = "";


  @override
  void initState() {
    super.initState();
    getMatricNo();
  }

  getMatricNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var matricNo = _sharedPreferences.getString('matricNo');
    getStudentProfile(matricNo);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: const Text(
              "Profile",
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
                onPressed: () => {
                  nextScreen(context, About())
                },
                 icon:const Icon(Icons.info_outline_rounded),
                ),
            ],
          ),
      drawer: MainDrawerStudent(home: false, profile: true, book: false, appointment: false, reward: false, chat: false, yourHistory: false),
    
          body: Padding(
            padding: Device.screenType == ScreenType.tablet? 
                     EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
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
                      )
                ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:  EdgeInsets.only(bottom: 2.0.h),
                          height: 14.0.h,
                
                        decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                       border: Border.all(
                    width:  5,
                    color: Constants().secondaryColor,
                   ),
                       image:   DecorationImage(
                         image: NetworkImage(studentImage),
                          ),
                         ),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:deviceWidth(context) * 0.06),
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name 
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric( horizontal: deviceWidth(context) * 0.03),
                                margin: EdgeInsets.only(bottom: deviceHeight(context) * 0.03),
                                child:   Text(
                                        studentName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Device.screenType == ScreenType.tablet? 
                                            25:14,
                                            fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                        ),
                                            
                              ),
                            ),
                            //matric number 
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),  
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.card_membership,
                                      color: Constants().messageGreyColor,
                                      size:  Device.screenType == ScreenType.tablet? 20:20,
                                    ),
                              
                                          SizedBox(width: 10.w ,),
                                           Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                            Flexible(
                                              child: Text(matricNumber,
                                              style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Device.screenType == ScreenType.tablet? 
                                              20:15,
                                              fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                              ),
                                              ),
                                            ),   
                                       Flexible(
                                         child: Text(
                                                    icNumber,
                                              style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Device.screenType == ScreenType.tablet? 
                                            20:15,
                                              fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            ),
                                            ),
                                       ),
                            
                                          ],
                                       ),         
                                    ],
                                ),
                              
                            ),
                           Divider(
                             color: Constants().dividerColor,
                               thickness: 1,
                           ),
                           
                             //telephone number 
                                Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Constants().messageGreyColor,
                                    size: Device.screenType == ScreenType.tablet? 20:20,
                                  ),
                                    SizedBox(width: 10.w ,),
                     
                                    Flexible(
                                      child: Text(studentTelephoneNumber,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Device.screenType == ScreenType.tablet? 
                                            20:15,
                                            fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                        ),
                                    ),
                             
                                  ],
                              ),
                            ),
                             Divider(
                             color: Constants().dividerColor,
                               thickness: 1,
                           ),
                             //email 
                                Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                           Icon(
                            Icons.email,
                            color: Constants().messageGreyColor,
                            size: Device.screenType == ScreenType.tablet? 20:20,
                           ),
                            SizedBox(width: 10.w ,),
                     
                              Flexible(
                                child: Text(studentEmail,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Device.screenType == ScreenType.tablet? 
                                    20:15,
                                    fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                                ),
                              ),
                              
                                  ],
                              ),
                            ),
                           Divider(
                             color: Constants().dividerColor,
                               thickness: 1,
                           ),
                            //faculty 
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                            Icon(
                              Icons.school,
                              color: Constants().messageGreyColor,
                              size: Device.screenType == ScreenType.tablet? 20:20,
                            ),
                              SizedBox(width: 10.w ,),                      
                                    Flexible(
                                      child: Text(
                                        faculty,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Device.screenType == ScreenType.tablet ? 20 : 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),    
                                
                                  ],
                              ),
                            ),
                            Divider(
                             color: Constants().dividerColor,
                               thickness: 1,
                           ),
                               //faculty 
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                            Icon(
                              Icons.school_rounded,
                              color: Constants().messageGreyColor,
                              size: Device.screenType == ScreenType.tablet? 20:20,
                            ),
                              SizedBox(width: 10.w ,),
                        
                                    Flexible(
                                      child: Text(
                                        program,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Device.screenType == ScreenType.tablet ? 20 : 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),

                                  ],
                              ),
                            ),

                              SizedBox(width: 10.w ,),
                             Divider(
                             color: Constants().dividerColor,
                               thickness: 1,
                           ),
                             //metamask account address
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01, horizontal: deviceWidth(context) * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                            Icon(
                              Icons.token,
                              color: Constants().messageGreyColor,
                              size: Device.screenType == ScreenType.tablet? 20:20,
                            ),
                          SizedBox(width: 10.w,),
                           Flexible(
                             child: Text(
                                tokenAddress,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Device.screenType == ScreenType.tablet? 
                                    20:15,
                                    fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                                ),
                           ),
                               
                                  ],
                              ),
                            ),
                        
        
                          ],
                        ),
                       ),
                      
                     ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  //function to get student profile
  getStudentProfile(String? matricNo) async {
     var responseStudent = await new Student().getStudentDetail(matricNo!);
    if(responseStudent['success']){
      setState(() {
      studentImage = responseStudent['student'][0]['studImage'];
      studentName = responseStudent['student'][0]['studName'];
      matricNumber = responseStudent['student'][0]['matricNo'];
      icNumber = responseStudent['student'][0]['icNumber'];
      studentTelephoneNumber = responseStudent['student'][0]['studTelephoneNo'];
      studentEmail = responseStudent['student'][0]['studEmail'];
      faculty = responseStudent['student'][0]['faculty'];
      program = responseStudent['student'][0]['program'];
      tokenAddress = responseStudent['student'][0]['tokenAddress'];
      });
    }else {
      throw Exception(responseStudent['message']);
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