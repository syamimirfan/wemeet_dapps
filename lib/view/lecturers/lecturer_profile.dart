import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import '../../shared/constants.dart';

class LecturerProfile extends StatefulWidget {
  const LecturerProfile({super.key});

  @override
  State<LecturerProfile> createState() => _LecturerProfileState();
}

class _LecturerProfileState extends State<LecturerProfile> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
   TextEditingController _floorLvl = TextEditingController();
   TextEditingController _roomNo = TextEditingController();
   TextEditingController _academicQualification1 = TextEditingController();
   TextEditingController _academicQualification2 = TextEditingController();
  TextEditingController _academicQualification3 = TextEditingController();
  TextEditingController _academicQualification4 = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String lectImage = "";
  int floorLevel = 0;
  int roomNumber = 0;
  String academicQualificationOne = "";
  String academicQualificationTwo = "";
  String academicQualificationThree = "";
  String academicQualificationFour = "";
  String studentName = "";
  String studentNameBookingUpdate = "";

  @override
  void initState() {
    super.initState();

    getStaffNo();
  }

  Future<void> getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    
    lecturerProfile( _sharedPreferences.getString('staffNo'));

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
      drawer: MainDrawerLecturer(home: false, profile: true, slot: false, appointment: false, attendance: false, chat: false),
    
          body: Padding(
            padding: Device.screenType == ScreenType.tablet? 
                    EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
                    EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
            child: Container(
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
                          height: Device.screenType == ScreenType.tablet ? 14.0.h : 14.0.h,
                
                        decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                       border: Border.all(
                    width: 5,
                    color: Constants().secondaryColor,
                   ),
                       image:  DecorationImage(
                         image: NetworkImage(lectImage),
                          ),
                         ),
                        ),
                      Form(
                        key: _globalKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:deviceWidth(context) * 0.06),
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             //Floor level
                            Text("Floor Level",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                                20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                  hintText: floorLevel.toString(),
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _floorLvl,
                              validator: (value) {
                                 if(value!.isEmpty) {
                                  _floorLvl =  TextEditingController(text: floorLevel.toString()) ;
                                  // return "Floor Level cannot be empty (enter:None if no data)";
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
                         //Room Number
                            Text("Room Number",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                              20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                 hintText: roomNumber.toString(),
                                 hintStyle: TextStyle(fontFamily: 'Poppins'),
                                 fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _roomNo,
                                validator: (value) {
                                 if(value!.isEmpty) {
                                      _roomNo = TextEditingController(text: roomNumber.toString()) ;
                                  // return "Room Number cannot be empty (enter:None if no data)";
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
                            //Academic Qualification 1
                            Text("Academic Qualification 1",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                              20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                  hintText: academicQualificationOne,
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _academicQualification1,
                               validator: (value) {
                                 if(value!.isEmpty) {
                                   _academicQualification1 = TextEditingController(text: academicQualificationOne) ;
                                  // return "Academic Qualification 1 cannot be empty (enter:None if no data)";
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
                           //Academic Qualification 2
                            Text("Academic Qualification 2",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                             20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                  hintText: academicQualificationTwo,
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _academicQualification2,
                              validator: (value) {
                                 if(value!.isEmpty) {
                                      _academicQualification2 = TextEditingController(text: academicQualificationTwo);
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
            
                            //Academic Qualification 3
                            Text("Academic Qualification 3",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                              20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                  hintText: academicQualificationThree,
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _academicQualification3,
                              validator: (value) {
                                 if(value!.isEmpty) {
                                  _academicQualification3 = TextEditingController(text: academicQualificationThree);
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
            
                            //Academic Qualification 4
                            Text("Academic Qualification 4",
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 71, 71),
                              fontSize: Device.screenType == ScreenType.tablet? 
                               20:15,
                              fontFamily: 'Poppins',
                            ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(    
                                style: TextStyle(fontFamily: 'Poppins'),
                              decoration: textInputDecorationMain.copyWith(
                                  hintText: academicQualificationFour,
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  fillColor: Color(0xffC0C0C0),
                              ),
                              controller: _academicQualification4,
                               validator: (value) {
                                 if(value!.isEmpty) {
                                  _academicQualification4 = TextEditingController(text: academicQualificationFour);
                                }
                                 return null;
                              },
                            ),   
                           const SizedBox(height: 30,),
            
                   SizedBox(
                     width: double.infinity,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().secondaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
    
                        ),
                  
                      onPressed: () async{
                          final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                            var staffNo = _sharedPreferences.getString('staffNo');
      
                          if(_globalKey.currentState!.validate()) {
                               updateLecturerInformation(staffNo, int.parse(_floorLvl.text.toString().trim()), int.parse(_roomNo.text.toString().trim()),_academicQualification1.text.toString().trim(), _academicQualification2.text.toString().trim(),   _academicQualification3.text.toString().trim(),  _academicQualification4.text.toString().trim());
                          }
                      },
                       child:  const Text(
                         "Save",
                         style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                         ),
                       ),
                      ),
                   ),
                          ],
                        ),
                       ),
                      
                      ),
                        const SizedBox(height: 30,),
                     ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
  
  //function to update the lecturer information
  updateLecturerInformation(String? staffNo, int floorLvl , int roomNo, String academicQualification1,String academicQualification2, String academicQualification3, String academicQualification4) async{
 
     var responseLecturer = await new Lecturer().lecturerInformation(staffNo!, floorLvl , roomNo, academicQualification1.trim(), academicQualification2.trim(), academicQualification3.trim(),academicQualification4.trim());

     if(responseLecturer['success']) {
        showMessage(context, "Saved", "Your information has successfully updated", "OK");
     }else {
       showMessage(context, "Ooops!", "Cannot save the information", "OK");
     }
  }

  //function to get lecturer profile
  lecturerProfile(String? staffNo) async {
    var responseLecturer = await new Lecturer().getLecturerProfile(staffNo!);
    if(responseLecturer['success']) {
      setState(() {
         lectImage = responseLecturer['lecturer'][0]['lecturerImage'];
         floorLevel = responseLecturer['lecturer'][0]['floorLvl'];
         roomNumber = responseLecturer['lecturer'][0]['roomNo'];
         academicQualificationOne = responseLecturer['lecturer'][0]['academicQualification1'];
         academicQualificationTwo = responseLecturer['lecturer'][0]['academicQualification2'];
         academicQualificationThree = responseLecturer['lecturer'][0]['academicQualification3'];
         academicQualificationFour = responseLecturer['lecturer'][0]['academicQualification4'];
      });
      print(lectImage);
    }else {
      throw Exception(responseLecturer['message']);
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


  //show message box function
  static void showMessage(BuildContext context, String title, String message, String buttonText) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
           content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
           actions: [ 
              ElevatedButton(
                onPressed: () {
                  nextScreenReplacement(context, LecturerProfile());
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
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