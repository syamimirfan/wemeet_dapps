import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/book2_student.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  List<String> faculty = ["FSKTM","FKEE","FKMP","FPTP","FPTV","FKAAB","FAST","FTK","PPS","PPD","PPB"];
 
  //variable for faculty category
  List<IconData> icons = [Icons.computer, Icons.electric_bolt, Icons.precision_manufacturing, Icons.business, Icons.cast_for_education, Icons.engineering, Icons.science, Icons.military_tech_outlined, Icons.school, Icons.book_rounded, Icons.book_online_outlined];

  int tappedIndex = 0;

  List<dynamic> lecturerList = [];
  List<dynamic> filterLecturerList = [];
  List<dynamic> filterListViewLecturerList = [];
  String selectedFaculty = "";

  String lectName = "";
  

  final TextEditingController _searchController = TextEditingController();

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
   
  @override
  void initState() {
    super.initState();
    getLecturer();
  }
  

  //function of faculty category widgets
  Widget facultyCategory() {
    return Container(
       padding: Device.screenType == ScreenType.tablet? 
                 EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.0001):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 11,
          itemBuilder:  (context, index) {
            return Container(
            width: Device.screenType == ScreenType.tablet? deviceWidth(context) * 0.21 : deviceWidth(context) * 0.32,
            padding: Device.screenType == ScreenType.tablet? EdgeInsets.all(10) : const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
               gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    tappedIndex == index? Constants().secondaryColor : Colors.white,
                    tappedIndex == index? Constants().secondaryColor : Colors.white,
                  ]
               ),
               borderRadius: BorderRadius.circular(20),
               border: Border.all(
                 width: Device.screenType == ScreenType.tablet? 5: 3,
               color: tappedIndex == index ? Colors.white : Color(0xffC0C0C0),
               ), 
            ),  
             child: ListTile(
              title: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                      Icon(icons[index], color: tappedIndex == index ? Colors.white : Colors.black, size: 30,),
                       SizedBox(height: 5,),
                     Text(
                      faculty[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:Device.screenType == ScreenType.tablet? 15:14,
                        fontFamily: 'Poppins',
                        color: tappedIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5,),
                 ],
                ),
              ),
              onTap: () {
                setState(() {
                  tappedIndex = index;
                  selectedFaculty = faculty[index];
                  filterListViewLecturerList = lecturerList.where((lecturer) =>lecturer['faculty']== selectedFaculty).toList();
                });
              },
             ),
            );
          }
        ),
    );
  }

  //function of list of lecturers
  Widget lecturers() {
    return Container(
       padding: Device.screenType == ScreenType.tablet? 
                 EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.03):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
           physics: const NeverScrollableScrollPhysics(),
          itemCount: selectedFaculty != "" ?  filterListViewLecturerList.length : _searchController.text.isNotEmpty ? filterLecturerList.length : lecturerList.length,
          itemBuilder:  (BuildContext context, int index) {
            return Container(
              padding: Device.screenType == ScreenType.tablet? 
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
              margin: Device.screenType == ScreenType.tablet? 
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01),
               width: deviceHeight(context) * 0.14,
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
              child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(selectedFaculty != "" ?  filterListViewLecturerList[index]['lecturerImage'] : _searchController.text.isNotEmpty ? filterLecturerList[index]['lecturerImage'] : lecturerList[index]['lecturerImage']),
            ),
            ),
             title: Flexible(
               child: Text( selectedFaculty != "" ?  filterListViewLecturerList[index]['lecturerName'] :
               _searchController.text.isNotEmpty ? filterLecturerList[index]['lecturerName'] :  lecturerList[index]['lecturerName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Device.screenType == ScreenType.tablet? 15:15,
                  fontFamily: "Poppins",
                  color: Colors.black,
                    ),
                   ),
             ),
           
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Flexible(
                        child: Text( selectedFaculty != "" ?  filterListViewLecturerList[index]['lecturerTelephoneNo'] :
                    _searchController.text.isNotEmpty ? filterLecturerList[index]['lecturerTelephoneNo'] :  lecturerList[index]['lecturerTelephoneNo'],
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Device.screenType == ScreenType.tablet? 15:15,
                        fontFamily: "Poppins",
                        color: Colors.black,
                      ),
                      
                        ),
                      ),
                    Row(
                      children: [
                        Flexible(
                          child: Text( selectedFaculty != "" ?  filterListViewLecturerList[index]['faculty'] :
                            _searchController.text.isNotEmpty ? filterLecturerList[index]['faculty'] : lecturerList[index]['faculty'],
                              style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Device.screenType == ScreenType.tablet? 12:12,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                           ),
                        ),
                           Flexible(
                             child: Text(",\tFLOOR "+ ( selectedFaculty != "" ?  filterListViewLecturerList[index]['floorLvl'].toString() : _searchController.text.isNotEmpty ? filterLecturerList[index]['floorLvl'].toString() : lecturerList[index]['floorLvl'].toString()),
                              style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Device.screenType == ScreenType.tablet? 12:12,
                              fontFamily: "Poppins",
                              color: Colors.black,
                                                     ),
                                                    ),
                           ),
                          Flexible(
                            child: Text( ",\tNO "+ ( selectedFaculty != "" ?  filterListViewLecturerList[index]['roomNo'].toString() : _searchController.text.isNotEmpty ? filterLecturerList[index]['roomNo'].toString() : lecturerList[index]['roomNo'].toString()),
                              style: TextStyle(
                              fontWeight: FontWeight.w400,
                               fontSize: Device.screenType == ScreenType.tablet? 12:12,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                                                   ),
                          )
                      ],
                    )
                  ],
                ),
                    
                onTap: () => {
                   nextScreen(context, Book2(staffNo: selectedFaculty != "" ?  filterListViewLecturerList[index]['staffNo'] : _searchController.text.isNotEmpty ? filterLecturerList[index]['staffNo'] : lecturerList[index]['staffNo']))
                }, 

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
          drawer: MainDrawerStudent(home: false, profile: false, book: true, appointment: false,  reward: false,chat: false, yourHistory: false,),
    
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
                     padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical:deviceWidth(context) * 0.03 ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Flexible(
                           child: Text(
                            "Choose Meet With",
                            style: TextStyle(
                                color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: Device.screenType == ScreenType.tablet? 20:20,
                              fontFamily: 'Poppins',
                            ),
                                                 ),
                         ),
                        const SizedBox(height: 10,),
                         Flexible(
                           child: Text(
                            "Your Hands",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:  Device.screenType == ScreenType.tablet? 20:20,
                              fontFamily: 'Poppins',
                            ),
                                                 ),
                         ),
                          const SizedBox(height: 15,),
                         Form(
                          child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              selectedFaculty = "";
                              filterLecturerList = lecturerList.where((list) => list['lecturerName'].toLowerCase().contains(value.toLowerCase())).toList();
                            });
                          },
                          
                          decoration: inputTextDecorationSearch.copyWith(
                            hintText: "Search...",
                            fillColor: Colors.white,
                            prefixIcon:Icon(Icons.search,color: Colors.grey,),
                          ),
                         ),
                        ),
                        const SizedBox(height: 20,),
                         Flexible(
                           child: Text(
                            "Category",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Device.screenType == ScreenType.tablet? 15:15,
                              fontFamily: 'Poppins',
                            ),
                                                 ),
                         ),
                        SizedBox(height: 150, child: facultyCategory(),),
                        lecturers(),
                      ],
                    ),
                  ),
                ),  
            ),
          ),
      ),
    );
  }

  //function to get all lecturer list
  Future<void> getLecturer() async {
    var responseLecturer = await new Lecturer().getLecturerList();

    if(responseLecturer['success']){
        final responseData = responseLecturer['lecturer'];
        if(responseData is List) {
          setState(() {
            lecturerList = responseData;
          });
        }else{
          print("Error fetching data: ${responseLecturer['message']}");
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