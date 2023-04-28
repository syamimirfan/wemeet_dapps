import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/message_tile.dart';

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

  List<dynamic> chat = [];

  final TextEditingController _controllerMessage = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.height;

  
  @override
  void initState() {
    super.initState();
     getStudent(matricNo);
     getStaffNo();
  }

   getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var staffNo = _sharedPreferences.getString('staffNo');
    getMessage(matricNo, staffNo);
  }

  //message
   message() {
    return ListView.builder(
      itemCount: chat.length,
      itemBuilder: (context,index) {
         return MessageTile(message: chat[index]['messageText'], isSentByMe: chat[index]['statusMessage'] == 2 ? true : false, date: chat[index]['sendTextTime'],chatId: chat[index]['chatId']);
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
                     addLecturerMessage(matricNo, staffNo!, _controllerMessage.text);
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
               radius: 20,
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
              fontWeight: FontWeight.w500,
             ),
            ),
           ),
          ],
        ),
      ),

      body: Padding(
      padding: Device.screenType == ScreenType.tablet? 
               const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: [
                      SizedBox(height: deviceHeight(context) * 0.78, child:  message(),),
                  sendingMessage()
                    ],
                ),
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

  //add lecturer message
  addLecturerMessage(String matricNo, String staffNo, String messageText) async {
     var responseChat = await new Chat().lecturerMessage(matricNo, staffNo, messageText);
     if(responseChat['success']) {
      //MAKE IT REFRESH SO WE CAN SEE THE MESSAGE
       await getMessage(matricNo, staffNo);
     }
  }

  
  //get all message
  getMessage(String matricNo, String? staffNo) async {
     var responseChat = await new Chat().getUserMessage(matricNo, staffNo!);
     if(responseChat['success']){
        final responseData = responseChat['chat'];
       if(responseData is List) {
         setState(() {
           chat = responseData;
           bool lastMessageSentByStudent = chat.isNotEmpty && chat.last['statusMessage'] == 1;
        if (lastMessageSentByStudent) {
          NotificationService().showNotification(
              title: 'New message from $studentName',
              body: chat.last['messageText']);
        }
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
     }
  }
}