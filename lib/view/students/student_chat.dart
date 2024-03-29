import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/view/students/student_message.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class StudentChat extends StatefulWidget {
  const StudentChat({super.key});

  @override
  State<StudentChat> createState() => _StudentChatState();
}

class _StudentChatState extends State<StudentChat> {

  List<dynamic> lecturers = [];
  List<dynamic> filterLecturers = [];
  String noData = "";

  String lectName = "";
  
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final TextEditingController _searchController = TextEditingController();
  
 @override
  void initState() {
    super.initState();

    getLecturerChat();

  }

  Widget buildChat() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03),
        child: ListView.builder(
        itemCount:_searchController.text.isNotEmpty ? filterLecturers.length : lecturers.length,
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
                      backgroundImage: NetworkImage(_searchController.text.isNotEmpty ? filterLecturers[index]['lecturerImage']: lecturers[index]['lecturerImage']),
                    ),
                     title:  Text(
                        _searchController.text.isNotEmpty ? filterLecturers[index]['lecturerName']:lecturers[index]['lecturerName'],
                        style:  TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Device.screenType == ScreenType.tablet?  18:18,
                          fontFamily: "Poppins"
                        ),
                      ),
                      onTap: () {
                        nextScreen(context, Message(staffNo: _searchController.text.isNotEmpty ? filterLecturers[index]['staffNo']:  lecturers[index]['staffNo']));
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
    
          drawer: MainDrawerStudent(home: false, profile: false, book: false, appointment: false, reward: false, chat: true, yourHistory: false),
    
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
                                  filterLecturers = lecturers.where((list) => list['lecturerName'].toLowerCase().contains(value.toLowerCase())).toList();
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
      ),
    );
  }

   //function to get lecturer chat
  getLecturerChat() async {
    final responseChat = await Chat().getChatStudents();
    if(responseChat['success']) {
      final responseData = responseChat['chat'];
      if(responseData is List) {
        setState(() {
          lecturers = responseData;
        });
      }else {
        setState(() {
          noData = responseChat['message'];
        });
       print("Error fetching data: ${responseChat['message']}");
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