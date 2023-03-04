import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/message_tile.dart';

class Message extends StatefulWidget {
  final String images;
  final String lecturerName;
  const Message({super.key, required this.images, required this.lecturerName});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
   
   //variable for message
  List<String> sendMessage = ["Asslamualaikum dear student",
   "Waalaikumussalam Dr, How about our appointment?",
   "You can come to my table at 8.30 AM",
   "Noted Dr","Asslamualaikum dear student",
   "Waalaikumussalam Dr, How about our appointment?",
   "You can come to my table at 8.30 AM",
   "Noted Dr"
  ];
  List<bool> sendByMe = [false,true,false,true,false,true,false,true];

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.height;

  //message
   message() {
    return ListView.builder(
      itemCount: sendMessage.length,
      itemBuilder: (context,index) {
        return MessageTile(message: sendMessage[index], isSentByMe: sendByMe[index]);
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
                child: TextFormField(
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
                  ),
                 ),
              ),
            ), 
             const SizedBox (width:12),
             GestureDetector(
               onTap: () {

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
              backgroundImage: AssetImage(widget.images),
          ),
            ),
            const SizedBox(width: 10,),
           Flexible(
            fit: FlexFit.loose,
            child: Text(
            "Dr "+widget.lecturerName,
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
              //  Stack(
       
              //   children: [
              //    message(),
              //    sendingMessage()
              //   ],
              // ),
            
          ),
      ),
    );
  }
}