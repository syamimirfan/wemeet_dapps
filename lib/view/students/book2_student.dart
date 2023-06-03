import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:wemeet_dapps/view/students/book_successful_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:intl/intl.dart';

class Book2 extends StatefulWidget {
  Book2({Key? key, required this.staffNo}) : super(key: key);

  String staffNo;

  @override
  State<Book2> createState() => _Book2State(this.staffNo);
}

class _Book2State extends State<Book2> {

  _Book2State(this.staffNo);
  String staffNo;

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

  List<dynamic> slot = [];
  List<dynamic> bookTime = [];
  List<dynamic> bookDate = [];
  List<dynamic> bookStatus = [];
  bool notAvailableDay = false;

  String lectNameBookingUpdate = "";

  @override
  void initState() {
    super.initState();
   
   getSelectedLecturer(staffNo);

  }

  getDate(String bookDate) {
     setState(() {
        date = bookDate;
     });
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
               title: Text(
                lectName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Device.screenType == ScreenType.tablet? 15:15,
                  fontFamily: "Poppins",
                  color: Colors.black,
                    ),
                   ),
             
                  subtitle: 
                      Text(
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

  //function for date
  Widget buildDate() {
    return Container(
       margin: const EdgeInsets.only(top: 20),
       child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Constants().secondaryColor,
        selectedTextColor: Colors.white,
        dayTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Device.screenType == ScreenType.tablet? 15:15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        dateTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Device.screenType == ScreenType.tablet? 15:15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        monthTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: Device.screenType == ScreenType.tablet? 15:15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        onDateChange: (date){
          setState(() {
            DateFormat dateFormatBooking = DateFormat('MMMMEEEEd');
            late String dateFormattedBooking = dateFormatBooking.format(date);

            getDate(dateFormattedBooking);
            
            getBookingSlot(staffNo, dateFormattedBooking);
            getBooked(staffNo, dateFormattedBooking);
          });
          
        },
       ),
    );
  }

  //function slot
  Widget buildSlot() {
    
     return Container(
       padding: Device.screenType == ScreenType.tablet? 
               EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.00001):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.006),
        child:ListView.builder(
          shrinkWrap: true,
          itemCount: slot.length,
          itemBuilder:   (context, index) {
            return Column(
                children: [
                  Row(
                    children: [  
                    slot[index]['slot1'] != "" && notAvailableDay == false ? 
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding:  Device.screenType == ScreenType.tablet? 
                                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.06, vertical: deviceHeight(context) * 0.007):
                                        EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.007),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                 bookTime.contains(slot[index]['slot1']) && bookDate.contains(date)  ? Constants().BoxShadowColor:tappedIndex == 1? Constants().secondaryColor : Colors.white,
                                 bookTime.contains(slot[index]['slot1']) && bookDate.contains(date)  ? Constants().BoxShadowColor:tappedIndex == 1 ? Constants().secondaryColor : Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                            color:  bookTime.contains(slot[index]['slot1']) && bookDate.contains(date)? Colors.white: tappedIndex == 1 ? Colors.white : Colors.black ,
                            ), 
                          ),  
                          child: Text(slot[index]['slot1'], style: TextStyle(fontFamily: 'Poppins',  fontSize: Device.screenType == ScreenType.tablet? 15:15, fontWeight: FontWeight.bold, color: bookTime.contains(slot[index]['slot1']) && bookDate.contains(date) ? Colors.white: tappedIndex == 1 ? Colors.white : Colors.black ),),
                        ),
                        onTap: bookTime.contains(slot[index]['slot1']) && bookDate.contains(date) ? null : () {
                            setState(() {
                              tappedIndex = 1;
                              time = slot[index]['slot1']; 
                            });
                        },
                      ) :  Container(),
                     slot[index]['slot2'] != "" && notAvailableDay == false ?  
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding:  Device.screenType == ScreenType.tablet? 
                                        const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                                        EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.007),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                 bookTime.contains(slot[index]['slot2']) && bookDate.contains(date) ? Constants().BoxShadowColor:tappedIndex == 2? Constants().secondaryColor : Colors.white,
                                 bookTime.contains(slot[index]['slot2']) && bookDate.contains(date) ? Constants().BoxShadowColor:tappedIndex == 2? Constants().secondaryColor : Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                            color: bookTime.contains(slot[index]['slot2']) && bookDate.contains(date) ? Colors.white: tappedIndex == 2 ? Colors.white : Colors.black ,
                            ), 
                          ),  
                          child: Text(slot[index]['slot2'], style: TextStyle(fontFamily: 'Poppins',  fontSize: Device.screenType == ScreenType.tablet? 15:15, fontWeight: FontWeight.bold, color: bookTime.contains(slot[index]['slot2']) && bookDate.contains(date) ? Colors.white:tappedIndex == 2 ? Colors.white : Colors.black,),),
                        ),
                          onTap:  bookTime.contains(slot[index]['slot2']) && bookDate.contains(date) ? null : () {
                             setState(() {
                              tappedIndex = 2;
                              time = slot[index]['slot2'];
                          
                            });
                        },
                      ):  Container(),
                       slot[index]['slot3'] != "" && notAvailableDay == false  ?
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding:  Device.screenType == ScreenType.tablet? 
                                        const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                                        EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.007),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  bookTime.contains(slot[index]['slot3']) && bookDate.contains(date)  ? Constants().BoxShadowColor: tappedIndex == 3? Constants().secondaryColor : Colors.white,
                                  bookTime.contains(slot[index]['slot3']) && bookDate.contains(date) ?  Constants().BoxShadowColor:tappedIndex == 3? Constants().secondaryColor : Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                            color: bookTime.contains(slot[index]['slot3']) && bookDate.contains(date) ? Colors.white: tappedIndex == 3 ? Colors.white : Colors.black ,
                            ), 
                          ),  
                          child: Text(slot[index]['slot3'], style: TextStyle(fontFamily: 'Poppins',  fontSize: Device.screenType == ScreenType.tablet? 15:15,fontWeight: FontWeight.bold, color:bookTime.contains(slot[index]['slot3']) && bookDate.contains(date) ? Colors.white: tappedIndex == 3 ? Colors.white : Colors.black ,),),
                        ),
                          onTap:  bookTime.contains(slot[index]['slot3']) && bookDate.contains(date) ? null :() {
                             setState(() {
                              tappedIndex = 3;
                             time = slot[index]['slot3'];       
                            }); 
                        },
                      ) : Container(),
                    ],
                  ),
                  SizedBox(height: 1.2.h,),
                  Row(
                    children: [
                       slot[index]['slot4'] != "" && notAvailableDay == false  ?
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding:  Device.screenType == ScreenType.tablet? 
                                        const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                                        EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.007),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    bookTime.contains(slot[index]['slot4']) && bookDate.contains(date) ? Constants().BoxShadowColor:tappedIndex == 4? Constants().secondaryColor : Colors.white,
                                    bookTime.contains(slot[index]['slot4']) && bookDate.contains(date) ? Constants().BoxShadowColor:tappedIndex == 4? Constants().secondaryColor : Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                            color: bookTime.contains(slot[index]['slot4']) && bookDate.contains(date) ? Colors.white: tappedIndex == 4 ? Colors.white : Colors.black ,
                            ), 
                          ),  
                          child: Text(slot[index]['slot4'], style: TextStyle(fontFamily: 'Poppins',  fontSize: Device.screenType == ScreenType.tablet? 15:15, fontWeight: FontWeight.bold, color:bookTime.contains(slot[index]['slot4']) && bookDate.contains(date) ? Colors.white:tappedIndex == 4 ? Colors.white : Colors.black ,),),
                        ),
                          onTap:   bookTime.contains(slot[index]['slot4']) && bookDate.contains(date) ? null : () {
                            setState(() {
                              tappedIndex = 4;
                              time = slot[index]['slot4'];                              
                            });
                        },
                      ) : Container(),
                       slot[index]['slot5'] != "" && notAvailableDay == false  ?
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding:  Device.screenType == ScreenType.tablet? 
                                        const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                                        EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.007),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                 bookTime.contains(slot[index]['slot5']) && bookDate.contains(date) ? Constants().BoxShadowColor:tappedIndex == 5? Constants().secondaryColor : Colors.white,
                                 bookTime.contains(slot[index]['slot5']) && bookDate.contains(date) ? Constants().BoxShadowColor: tappedIndex == 5? Constants().secondaryColor : Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                            color:bookTime.contains(slot[index]['slot5']) && bookDate.contains(date) ? Colors.white: tappedIndex == 5 ? Colors.white : Colors.black ,
                            ), 
                          ),  
                          child: Text(slot[index]['slot5'], style: TextStyle(fontFamily: 'Poppins',  fontSize: Device.screenType == ScreenType.tablet? 15:15, fontWeight: FontWeight.bold, color: bookTime.contains(slot[index]['slot5']) && bookDate.contains(date) ? Colors.white: tappedIndex == 5 ? Colors.white : Colors.black ,),),
                        ),
                          onTap:  bookTime.contains(slot[index]['slot5']) && bookDate.contains(date) ? null : () {
                              setState(() {
                              tappedIndex = 5;
                              time = slot[index]['slot5'];
                            });
                        },
                      ): Container(),
                    ],
                  ),
                ],
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
          title: const Text(
            "Book",
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
                         Text(
                          "Your Lecturer: ",
                          style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                             fontSize: Device.screenType == ScreenType.tablet? 18:18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        selectedLecturer(),
                        const SizedBox(height: 30,),
                            Text(
                          "Number of Students",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Device.screenType == ScreenType.tablet? 18:20,
                            fontFamily: 'Poppins',
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
                          const SizedBox(height: 20,),
                            Text(
                          "Date",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                             fontSize: Device.screenType == ScreenType.tablet? 18:20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        buildDate(),
                         const SizedBox(height: 20,),
                           Text(
                          "Slot",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                             fontSize: Device.screenType == ScreenType.tablet? 18:20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                          
                         SizedBox(height: Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.40: deviceHeight(context) * 0.17,child: buildSlot()),
    
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
                        if(_globalKey.currentState!.validate() && date != "" && time != ""){
                           final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                           String? matricNo = _sharedPreferences.getString('matricNo');
                           addBooking(matricNo!, staffNo,int.parse( _numberOfStudents.text), date, time);
                        }else {
                          showMessage(context, "Booking Not Added", "Please enter the requirement for booking", "Ok");
                   
                        }
                      },
                       child:   Text(
                         "Confirm Appointment",
                         style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                         ),
                       ),
                      ),
                                   ),
                                   SizedBox(height: deviceHeight(context) * 0.04,)
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

  //function to get booking slot based on lecturer schedule
  getBookingSlot(String? staffNo, String day) async {
   
      var responseBooking = await new Booking().getBookingSlot(staffNo!, day);
       if(responseBooking['success']) {
       final responseData = responseBooking['slot'];
       if(responseData is List) {
        setState(() {
         slot = responseData;
         notAvailableDay = false;
        });
       }else {
        setState(() {
          notAvailableDay = true;
        });
  
          print("Error fetching data: ${responseBooking['message']}");
       }
     }

  }
  
  //function to add book
  addBooking(String matricNo, String staffNo, int numberOfStudents, String date, String time,) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var responseBooking = await new Booking().addBooking(matricNo, staffNo, numberOfStudents, date, time);

    if(responseBooking['success'] && responseBooking['message'] == "Slot Booked" ) {
      showMessage(context, "Slot Booked!", "The slot has been booked by student name ${responseBooking['student'][0]['studName']} with matric number ${responseBooking['student'][0]['matricNo']}", "OK");
      
    }else if(responseBooking['success']) {
      _sharedPreferences.setInt("bookingAdd", 1);
      _sharedPreferences.setString("bookingAddMatricNumber", matricNo);
      nextScreenReplacement(context, BookSuccessful(lecturerName: lectName, numberOfStudents: numberOfStudents, date: date, time: time));
    }else {
    showMessage(context, "Ooops!", "Cannot book the slot", "OK");
    }
  }
  
  //function to get booked slot
  getBooked(String staffNo, String date) async {
    final responseBooking = await new Booking().getBookedSlot(staffNo, date);
    if(responseBooking['success']) {
       final responseData = responseBooking['booking'];
         if(responseData is List){
            setState(() {
          bookTime = responseData.where((booking) => booking['statusBooking'] != "Rejected").map((booking) => booking['time']).toList();
          bookDate = responseData.where((booking) => booking['statusBooking'] != "Rejected").map((booking) => booking['date']).toList();
          });
         }else {
           return null;
         }
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