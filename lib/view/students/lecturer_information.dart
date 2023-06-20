import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';

class LecturerInformation extends StatefulWidget {

  final String staffNo;
  
  LecturerInformation({Key? key, required this.staffNo}): super(key: key);

  @override
  State<LecturerInformation> createState() => _LecturerInformationState(this.staffNo);
}

class _LecturerInformationState extends State<LecturerInformation> {
  
  _LecturerInformationState(this.staffNo);
  
  String staffNo;
  
  String lectImage = "";
  String lectTelephoneNo = "";
  String lectName = "";
  String faculty = "";
  int floorLvl = 0;
  int roomNo = 0;
  String department = "";

  String academicQualification1 = "";
  String academicQualification2 = "";
  String academicQualification3 = "";
  String academicQualification4 = ""; 

  String lectNameBookingUpdate = "";

 
  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();

    getLecturerInformation(staffNo);
 
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                 EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.001):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.001),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //first row (picture, staffNo and so on)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                            padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.03, horizontal: deviceWidth(context) *0.01),
                             //for lecturer images
                              child: CircleAvatar(
                              radius: Device.screenType == ScreenType.tablet? 80 : 50,
                              backgroundImage: NetworkImage(lectImage),
                            ),
                          ),
            
                          SizedBox(width: 20,),
                          //for lecturer basic information
                           Flexible(
                                  child: Container(
                                    padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.04, horizontal: deviceWidth(context) *0.01),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                                 EdgeInsets.only(bottom: deviceWidth(context) * 0.01):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Flexible(
                                                child: Text(
                                                staffNo,
                                                  style:TextStyle(
                                                      fontSize: Device.screenType == ScreenType.tablet? 
                                                                  30:20,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                          ),
                                          Container(
                                            margin: Device.screenType == ScreenType.tablet? 
                                                const EdgeInsets.only(bottom: 20):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Flexible(
                                                child: Text(
                                                  lectTelephoneNo,
                                                  style:TextStyle(
                                                      fontSize: Device.screenType == ScreenType.tablet? 
                                                                 20:20,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                          ),
                                          Container( 
                                             margin: Device.screenType == ScreenType.tablet? 
                                                const EdgeInsets.only(bottom: 20):
                                                EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                              child: Flexible(
                                                child: Text(
                                                faculty + ", LEVEL " + floorLvl.toString() + ", NO "+ roomNo.toString(),
                                                  style:TextStyle(
                                                      fontSize: Device.screenType == ScreenType.tablet? 
                                                                  20:20,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                          ),         
                                      ],
                                    ),
                                  )
                                 ),
                          ],
                       ),
                      //for lecturer name
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                        child:  Flexible(
                          child: Text(
                            lectName,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                         20:18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
            
                      //for divider between basic information and academic information
                       Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05),
                        child:  Divider(
                        color: Constants().dividerColor,
                        thickness: 2,
                       ),
                      ),
            
                      //for department
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                      child: Flexible(
                        child: Text(
                          department,
                           style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                        20:18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            
                    //for academic qualification title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                        padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.06),
                        child: Flexible(
                          child: Text(
                          "Academic Qualification",
                           style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                        20:18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ), 
                           ),
                        ),
                        ),
                      ],
                    ),
            
                    //for academic qualification content
                    Column(
                      children: [
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                          child: Flexible(
                            child: Text(
                            academicQualification1,
                                                   style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                        20:18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.justify,
                                                   ),
                          ),
                        ),
                              Container(
                          padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                          child: Flexible(
                            child: Text(
                              academicQualification2,
                                style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                       20:18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.justify,
                                                   ),
                          ),
                        ),
                              Container(
                          padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                          child: Flexible(
                            child: Text(
                              academicQualification3,
                                style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                        20:18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.justify,
                                                   ),
                          ),
                        ),
                              Container(
                          padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                          child: Flexible(
                            child: Text(
                              academicQualification4,
                                style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: Device.screenType == ScreenType.tablet? 
                                        20:18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ), 
                            textAlign: TextAlign.justify,
                                                   ),
                          ),
                        ),
                      ],
                    ),
                  ],
              ),
          ),
        ),
      ),
    );
  }

  //get lecturer information 
  getLecturerInformation(String staffNo) async {
     final responseStudent = await new Student().getLecturerInformationDetail(staffNo);

     if(responseStudent['success']){
        setState(() {
          lectImage = responseStudent['lecturer'][0]['lecturerImage'];
          lectName = responseStudent['lecturer'][0]['lecturerName'];
          lectTelephoneNo = responseStudent['lecturer'][0]['lecturerTelephoneNo'];
          department = responseStudent['lecturer'][0]['department'];
          faculty = responseStudent['lecturer'][0]['faculty'];
          floorLvl = responseStudent['lecturer'][0]['floorLvl'];
          roomNo = responseStudent['lecturer'][0]['roomNo'];
          academicQualification1 = responseStudent['lecturer'][0]['academicQualification1'];
          academicQualification2 = responseStudent['lecturer'][0]['academicQualification2'];
          academicQualification3 = responseStudent['lecturer'][0]['academicQualification3'];
          academicQualification4 = responseStudent['lecturer'][0]['academicQualification4'];
        });
     }else{
      throw Exception("Error fetching data");
     }
  }


     //to view some of lecturer data  
   viewLecturer(String? staffNo) async {
      var responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
      if(responseLecturer['success']) {
         setState(()  {
           lectNameBookingUpdate = responseLecturer['lecturer'][0]['lecturerName'];
           
         });
      } else {
         throw Exception("Failed to get the data");
      }
  }

}