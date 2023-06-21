import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/update_successful.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class UpdateBookNumberStudent extends StatefulWidget {
    
  final String staffNo;
  final int bookingId;
  
  UpdateBookNumberStudent({Key? key, required this.staffNo, required this.bookingId }): super(key: key) ;
  
  @override
  State<UpdateBookNumberStudent> createState() => _UpdateBookNumberStudentState(this.staffNo, this.bookingId);
}

class _UpdateBookNumberStudentState extends State<UpdateBookNumberStudent> {
  _UpdateBookNumberStudentState(this.staffNo, this.bookingId);

  String staffNo;
  int bookingId;

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    
  final TextEditingController _numberOfStudents = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

   int tappedIndex = 0;

  String lectImage = "";
  String lectName = "";
  String phoneNo = "";
  String faculty = "";
  int floorLvl = 0;
  int roomNo = 0;
  
  String date = "";
  String time = "";

  String lectNameBookingUpdate = "";


    @override
  void initState() {
    super.initState();

   getSelectedLecturer(staffNo);

   UpdateBookInformation(bookingId);
  }




//function for chosen lecturer
  Widget selectedLecturer() {
     return Container(
        padding: Device.screenType == ScreenType.tablet? 
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
      margin: Device.screenType == ScreenType.tablet? 
                 EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01),
        decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
 
               boxShadow: [
                  BoxShadow(
                    color: Constants().BoxShadowColor,
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
       child: ListTile(
         leading: Container(
                height: 300,
                width: 50,
                child: CircleAvatar(
                backgroundImage: NetworkImage(lectImage),
              ),
              ),
               title:  Text(
                  lectName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Device.screenType == ScreenType.tablet? 15:15,
                    fontFamily: "Poppins",
                    color: Colors.black,
                      ),
                     ),
               
             
                  subtitle: Text(
                        phoneNo + "\n" + faculty + ",\t" + floorLvl.toString() + ",\t" + roomNo.toString() ,
                        style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Device.screenType == ScreenType.tablet? 12:12,
                        fontFamily: "Poppins",
                        color: Colors.black,
                                   ),
                           ),
                      
       ),
     );
  }
  //function show dialog
  Future dialog(){
    return showDialog(
      context: context, 
      builder: (context) {
          return AlertDialog(
             title:  const Text("Confirm?",  
                  style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
            ),
            content: const Text("Are you sure to update the session?",
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
                   updateBook(bookingId, int.parse(_numberOfStudents.text));

                 }, 
                icon: const Icon(Icons.done, color: Colors.green,size: 30,)),
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
            "Update Number Of Students",
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
                  child: Form(
                    key: _globalKey,
                    child: Container(
                      padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical:deviceWidth(context) * 0.05),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Flexible(
                           child: Text(
                            "Your Lecturer: ",
                            style: TextStyle(
                                color: Colors.black,
                              fontWeight: FontWeight.w400,
                               fontSize: Device.screenType == ScreenType.tablet? 18:18,
                              fontFamily: 'Poppins',
                            ),
                                                 ),
                         ),
                        selectedLecturer(),
                        const SizedBox(height: 30,),
                            Flexible(
                              child: Text(
                                                      "Number of Students",
                              style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Device.screenType == ScreenType.tablet? 18:20,
                              fontFamily: 'Poppins',
                                                      ),
                                                    ),
                            ),
                              TextFormField(    
                              controller: _numberOfStudents,
                              keyboardType: TextInputType.number,
                              decoration: textInputDecorationNumberStudent.copyWith(
                                    hintText: "e.g, 2",
                                    fillColor: Color(0xffC0C0C0),
                                ),
                              validator: (value) {
                                 if(value!.isEmpty) {
                                  return "Please enter number of students for meeting";
                                }
                                 return null;
                              },
                            ),
                         SizedBox(height: deviceHeight(context) * 0.4,),   
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
                    if(_globalKey.currentState!.validate() ){
                               dialog();
                      }else {
                        showMessage(context, "Booking Not Added", "Please enter the requirement for booking", "Ok");                   
                         }            
                     
                      },
                       child:  Text(
                         "Update Appointment",
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
              ),
          ),
        ),
     );
   }

  //function to get selected lecturer
  getSelectedLecturer(String? staffNo) async {
     var responseLecturer = await new Lecturer().getLecturerBook2(staffNo!);

     if(responseLecturer['success']) {
      setState(() {
        lectImage = responseLecturer['lecturer'][0]['lecturerImage'];
        lectName = responseLecturer['lecturer'][0]['lecturerName'];
        phoneNo = responseLecturer['lecturer'][0]['lecturerTelephoneNo'];
        faculty = responseLecturer['lecturer'][0]['faculty'];
        floorLvl = responseLecturer['lecturer'][0]['floorLvl'];
        roomNo = responseLecturer['lecturer'][0]['roomNo'];
      });
      }
   }

  //function to update book
  updateBook(int bookingId, int numberOfStudents) async {
    var responseBooking = await new Booking().updateNoStudentsAppointment(bookingId, numberOfStudents);

   if(responseBooking['success']) {
      nextScreenReplacement(context, UpdateSuccessful(lecturerName: lectName, numberOfStudents: numberOfStudents, date: date, time: time));
    }else {
    showMessage(context, "Ooops!", "Cannot update the book slot", "OK");
    }
  }

  //get updated book information
  UpdateBookInformation(int bookingId) async {
     var responseBooking = await new Booking().getBookingAppointment(bookingId);
     if(responseBooking['success']){
       setState(() {
          date = responseBooking['booking'][0]['date'];
          time = responseBooking['booking'][0]['time'];
       });
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
                 nextScreenPop(context);
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
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