import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/constants/utils.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/message_tile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class LecturerMessage extends StatefulWidget {

   LecturerMessage({super.key, required this.matricNo});
   String matricNo;

  @override
  State<LecturerMessage> createState() => _LecturerMessageState(this.matricNo);
}

class _LecturerMessageState extends State<LecturerMessage> {
  
  _LecturerMessageState(this.matricNo);
  String matricNo;


  late String studentImage = "";
  late String studentName = "";
  late String lecturerName = "";


  String studentNameBookingUpdate = "";

  List<dynamic> chat = [];

  String studentNameBookingAdd = "";

  final TextEditingController _controllerMessage = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.height;

  
  @override
  void initState() {
    super.initState();
    getStudent(matricNo);
    getStaffNo();
    socket = IO.io('${Utils.baseURL}',
       IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .build()
    );
    socket.connect(); 
    setUpSocketListener();
  }


   getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var staffNo = _sharedPreferences.getString('staffNo');
    getMessage(matricNo, staffNo);
    getLecturer(staffNo);
    getAppointment(staffNo);
    getAppointmentUpdated(staffNo);
  }

  void sendMessageRealTime(String messageText, String matricNo, String staffNo) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
    var messageJson = {"matricNo":matricNo, "staffNo": staffNo, "messageText": messageText, "sendTextTime": formattedDate, "statusMessage": 2};
    socket.emit('message', messageJson);
  }
  
  
  void setUpSocketListener() {
      socket.on('message-receive', (data) {
       print(data);  
      setState(() {
        chat.add(data);
      });   
           NotificationService().showNotification(
              title: 'New message from $studentName',
              body: chat.last['messageText']);
       // Scroll to the bottom of the chat
       Future.delayed(Duration(milliseconds: 100), () {
          try {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          } catch (error) {
            print('Error scrolling to bottom: $error');
          }
      });
    });
  }
 
  //message
   message() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: chat.length,
        itemBuilder: (context,index) {
           return MessageTile(message: chat[index]['messageText'], isSentByMe:chat[index]['statusMessage'] == 2 ? true : false, date: chat[index]['sendTextTime']);
        }
    );
  }

  //to input message
  Widget sendingMessage(){
    return Container(
       alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
       child: Container(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
         child: Row(
          children: [
            Flexible(
              child:  Form(
                key: _globalKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: TextFormField(
                controller: _controllerMessage,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Poppins"
                  ),
                decoration:  InputDecoration(
                  fillColor: Constants().BoxShadowColor,
                  filled: true,
                  hintText: "Send a message...",
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Poppins"
                   ),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Constants().BoxShadowColor ),
                     ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Constants().BoxShadowColor),
                  ),
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Constants().BoxShadowColor ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Constants().BoxShadowColor),
                  ),
                  ),
                    validator: (value) {
                     if(value!.trim().isEmpty) {
                          return null;
                       }
                     return null;
                    },
                 ),
              ),
            ), 
             const SizedBox (width:12),
             GestureDetector(
               onTap: () async {
                  //INPUT THE MESSAGE RIGHT HERE
                final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                String? staffNo = _sharedPreferences.getString('staffNo');
                if(_globalKey.currentState!.validate() && _controllerMessage.text.trim().isNotEmpty){
                     addLecturerMessage(matricNo, staffNo!, _controllerMessage.text, _scrollController);
                     _controllerMessage.clear(); 
                }
               },
               child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Constants().secondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Icon(Icons.send, color: Colors.white),
                ),
               ),
             ),
          ],
         ),
       ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
               child: CircleAvatar(
                radius: Device.screenType == ScreenType.tablet?  25 : 20,
              backgroundImage: NetworkImage(studentImage),
          ),
            ),
            const SizedBox(width: 10,),
           Flexible(
            fit: FlexFit.loose,
            child: Text(
           studentName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize:20,
              fontWeight: FontWeight.w400,
             ),
            ),
           ),
          ],
        ),
      ),

      body: Padding(
      padding: Device.screenType == ScreenType.tablet? 
               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
            ),
            child: Column(
                    children: [
                      Expanded(child: SizedBox(height:Device.screenType == ScreenType.tablet? deviceHeight(context) * 0.85 : deviceHeight(context) * 0.78, child:  message(),)),
                      sendingMessage()
                    ],
                ),
 
          ),
      ),
    );
  }

  //get specific student
    getStudent(String matricNo) async{
     var responseChat = await new Chat().getContactStudent(matricNo);

     if(responseChat['success']) {
       setState(() {
         studentImage = responseChat['chat'][0]['studImage'];
         studentName = responseChat['chat'][0]['studName'];
       });
     }
  }

  //get specific lecturer name
  getLecturer(String? staffNo) async{
     var responseChat = await new Chat().getContactLecturer(staffNo!);

     if(responseChat['success']) {
       setState(() {
         lecturerName = responseChat['chat'][0]['lecturerName'];
       });
     }
  }

  //add lecturer message
  addLecturerMessage(String matricNo, String staffNo, String messageText, ScrollController scrollController) async {
      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
        DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
     var responseChat = await new Chat().lecturerMessage(matricNo, staffNo, messageText, formattedDate);
     
     if(responseChat['success']) {
      sendMessageRealTime(messageText,matricNo,staffNo);
      
      //MAKE IT REFRESH SO WE CAN SEE THE MESSAGE
      await getMessage(matricNo, staffNo);

      
        _sharedPreferences.setString("lecturerName", lecturerName);
       _sharedPreferences.setString("staffNumber", staffNo);
        
            // Scroll to the bottom of the chat after a short delay
       Future.delayed(Duration(milliseconds: 100), () {
          try {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          } catch (error) {
            print('Error scrolling to bottom: $error');
          }
      });
     }
  }

  @override
  void dispose() {
    socket.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  
  //get all message
  getMessage(String matricNo, String? staffNo) async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     var responseChat = await new Chat().getUserMessage(matricNo, staffNo!);
     if(responseChat['success']){
        final responseData = responseChat['chat'];
       if(responseData is List) {

         setState(() {
           chat = responseData;
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
     }
  }

      //to view some of student data
    viewStudent(String? matricNo) async {
      var responseStudent = await new Student().getStudentDetail(matricNo!);
      if(responseStudent['success']) {
         setState(()  {
           studentNameBookingAdd = responseStudent['student'][0]['studName'];
         });
      } else {
         throw Exception("Failed to get the data");
      }
 
  }

   //get all appointment in lecturer
  getAppointment(String? staffNo) async {
      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final responseBooking = await new Booking().getAppointmentRequest(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          bool currentAppointmentRequested = responseData.isNotEmpty && responseData.last['statusBooking'] == "Appending";
          if(currentAppointmentRequested && _sharedPreferences.getInt("bookingAdd") == 1 && _sharedPreferences.getString("bookingAddMatricNumber") != ""){
           viewStudent(_sharedPreferences.getString("bookingAddMatricNumber")).then((value) => {
             NotificationService()
            .showNotification(title: "New Appointment" ,body: studentNameBookingAdd + " has book an appointment session with you").then((value) => {
              _sharedPreferences.remove("bookingAdd"),
              _sharedPreferences.remove("bookingAddMatricNumber")
            })
           });
          }
        });
      }else {
  
        print(responseBooking['message']);
      }
    }
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

   //get all accepted appointment for manage appointment in lecturer
  getAppointmentUpdated(String? staffNo) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final responseBooking = await new Booking().getAcceptedAppointment(staffNo!);
    if(responseBooking['success']){
      final responseData = responseBooking['booking'];
      if(responseData is List){
        setState(() {
          if(_sharedPreferences.getInt("bookingUpdate") == 1 && _sharedPreferences.getString("bookingUpdateMatricNumber") != ""){
            viewStudentBookingUpdate(_sharedPreferences.getString("bookingUpdateMatricNumber")).then((value) => {
             NotificationService()
            .showNotification(title: "Appointment Updated!" ,body: studentNameBookingUpdate + " has update an appointment session with you").then((value) => {
              _sharedPreferences.remove("bookingUpdate"),
              _sharedPreferences.remove("bookingUpdateMatricNumber")
            })
           });
          }
        });
      }else {
        print(responseBooking['message']);
      }
    }
  }
}