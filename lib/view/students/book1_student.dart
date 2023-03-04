import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
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
  List<String> facultyLecturer = ["FSKTM","FSKTM","FSKTM","FSKTM","FSKTM"];
  List<int> floorLvl = [7,3,1,2,1]; 
  //variable for faculty category
  List<IconData> icons = [Icons.computer, Icons.electric_bolt, Icons.precision_manufacturing, Icons.business, Icons.cast_for_education, Icons.engineering, Icons.science, Icons.military_tech_outlined, Icons.school, Icons.book_rounded, Icons.book_online_outlined];

  //variable for list of lecturers
  List<String> images = ["assets/lecturer.png", "assets/icon.png","assets/icon.png","assets/icon.png","assets/icon.png"];
  List<String> lecturerName = ["Nur Ariffin Bin Mohd Zin", "Zainuri Bin Saringat", "Salama A Mostafa", "Mazidah Binti Mat Rejab", "Noraini Binti Ibrahim"];
  List<String>  number = ["10","15","11","9","20","12","15","10","2","5","6"];  
  List<int> roomNo = [12,11,9,5,3];
  int tappedIndex = 0;
  List<String> telephoneNo = ["0127534475","0127534475","0127534475","0127534475","0127534475"];

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  //function of faculty category widgets
  Widget facultyCategory() {
    return Container(
       padding: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 11,
          itemBuilder:  (context, index) {
            return Container(
            width: deviceHeight(context) * 0.14,
            padding: const EdgeInsets.all(10),
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
                 width: 3,
               color: tappedIndex == index ? Colors.white : Color(0xffC0C0C0),
               ), 
            ),  
             child: ListTile(
              title: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                      Icon(icons[index], color: tappedIndex == index ? Colors.white : Colors.black, size: 40,),
                       SizedBox(height: 5,),
                     Text(
                      faculty[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 0.25.dp,
                        fontFamily: 'Poppins',
                        color: tappedIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.01, ),
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          tappedIndex == index? Color(0xffFC7979) : Color(0xffE5E3E3),
                          tappedIndex == index? Color(0xffFC7979) : Color(0xffE5E3E3),
                        ],
                          ),
                         borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                          width: deviceWidth(context) * 0.0001,
                          color: tappedIndex == index ? Color(0xffFC7979)  : Color(0xffE5E3E3),
                           ), 
                        ),
                        child: Text(
                          number[index] + "\nLecturer",
                          textAlign: TextAlign.center,
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 0.209.dp,
                        fontFamily: 'Poppins',
                        color: tappedIndex == index ? Colors.white : Colors.black,
                      ),
                        ),
                      )
                 ],
                ),
              ),
              onTap: () {
                setState(() {
                  tappedIndex = index;
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
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
           physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder:  (context, index) {
            return Container(
              padding: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
              margin: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
              backgroundImage: AssetImage(images[index]),
            ),
            ),
             title: Text(
              "DR\t" + lecturerName[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: "Poppins",
                color: Colors.black,
                  ),
                 ),
           
                subtitle: 
                    Text(
                  telephoneNo[index] + "\n" + facultyLecturer[index] + ",\tFLOOR "+ floorLvl[index].toString() + ",\tNO " +roomNo[index].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
              
                    ),
                onTap: () => {
                   nextScreen(context, Book2())
                }, 
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
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
                   padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical:deviceWidth(context) * 0.03 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose Meet With",
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        "Your Hands",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Poppins',
                        ),
                      ),
                        const SizedBox(height: 15,),
                       Form(
                        child: TextFormField(
                        decoration: inputTextDecorationSearch.copyWith(
                          hintText: "Search",
                          fillColor: Colors.white,
                          prefixIcon:Icon(Icons.search,color: Colors.grey,),
                        ),
                       ),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
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
    );
  }
}