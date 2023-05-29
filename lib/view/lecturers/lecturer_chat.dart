import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

import 'lecturer_message.dart';

class LecturerChat extends StatefulWidget {
  const LecturerChat({super.key});

  @override
  State<LecturerChat> createState() => _LecturerChatState();
}

class _LecturerChatState extends State<LecturerChat> {


List<dynamic> students = [];
  List<dynamic> filterStudents = [];
  String noData = "";
  
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final TextEditingController _searchController = TextEditingController();
  
 @override
  void initState() {
    super.initState();

    getStudentChat();
    
  }


  Future<void> getStaffNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    
    var staffNo = _sharedPreferences.getString('staffNo');
    getMessage(staffNo);
  }


  Widget buildChat() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03),
        child: ListView.builder(
        itemCount: _searchController.text.isNotEmpty ? filterStudents.length : students.length,
        itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: deviceHeight(context) * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(_searchController.text.isNotEmpty ? filterStudents[index]['studImage']: students[index]['studImage']),
                    ),
                     title:  Text(
                      _searchController.text.isNotEmpty ? filterStudents[index]['studName']: students[index]['studName'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Device.screenType == ScreenType.tablet?  0.15.dp : 0.32.dp,
                          fontFamily: "Poppins"
                        ),
                      ),
                      onTap: () {
                        nextScreen(context, LecturerMessage(matricNo: _searchController.text.isNotEmpty ? filterStudents[index]['matricNo']:  students[index]['matricNo']));
                      },
                  ), 
                ],
              ),
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
        backgroundColor: Theme.of(context).primaryColor,
        title:  const Text(
            "Chat",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        actions: [
              IconButton(
              onPressed: () { 
                nextScreen(context, About());
              },
              icon: Icon(Icons.info_outline_rounded)
             ),
          ],
        ),

        drawer: MainDrawerLecturer(home: false, profile: false, slot: false, appointment: false, attendance: false, chat: true),

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for search and filter the chat
                    Container(
                      padding: Device.screenType == ScreenType.tablet ? 
                               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.04):
                               EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.04, vertical: deviceHeight(context) * 0.04),
                     child: Form(
                        child: TextFormField(
                        decoration: inputTextDecorationSearch.copyWith(
                          hintText: "Search",
                          fillColor: Colors.white,
                          prefixIcon:Icon(Icons.search,color: Colors.grey,),
                        ),
                           controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                                filterStudents = students.where((list) => list['studName'].toLowerCase().contains(value.toLowerCase())).toList();
                          });
                        },
                      ),
                    ),
                  ),
                    SizedBox(height:deviceHeight(context) * 1, child: buildChat(),),
                ],
              ),
             ),
          ),
        ),
    );
  }

  //function to get lecturer chat
  getStudentChat() async {
    final responseChat = await Chat().getChatLecturers();
    if(responseChat['success']) {
      final responseData = responseChat['chat'];
      if(responseData is List) {
        setState(() {
          students = responseData;
        });
      }else {
        setState(() {
          noData = responseChat['message'];
        });
       print("Error fetching data: ${responseChat['message']}");
      }
    }
  }

    //to get notification message from student
   getMessage(String? staffNo) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String? matricNo = _sharedPreferences.getString("matricNumber");
     var responseChat = await new Chat().getUserMessage(matricNo!, staffNo!);
     if(responseChat['success']){
        final responseData = responseChat['chat'];
       if(responseData is List) {
         setState(() {
        bool lastMessageSentByStudent = responseData.isNotEmpty && responseData.last['statusMessage'] == 1;
        if (lastMessageSentByStudent && _sharedPreferences.getString("studentName") != "" && _sharedPreferences.getString("matricNumber") != "") {
        var studentName = _sharedPreferences.getString("studentName");
          NotificationService().showNotification(
              title: 'New message from $studentName',
              body: responseData.last['messageText']).then((value) => {
                 _sharedPreferences.remove("studentName"),
                 _sharedPreferences.remove("matricNumber")
              });
          }
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
     }
   }
}