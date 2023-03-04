import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/update_successful.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key});

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
    double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  //date variable
  DateTime selectedDate = DateTime.now();

  //slot variable
  late String color;
  late String backgroundColor;
  int tappedIndex = 0;
  bool isBook = false;
  List<String> slot = ["8.00 AM", "10.00 AM", "12.00 PM", "2.00 PM", "4.00 PM"];

  //function for chosen lecturer
  Widget selectedLecturer() {
     return Container(
        padding: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.02),
      margin: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
                backgroundImage: AssetImage("assets/lecturer.png"),
              ),
              ),
               title: Text(
                "DR Nur Ariffin Bin Mohd Zin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: "Poppins",
                  color: Colors.black,
                    ),
                   ),
             
                  subtitle: 
                      Text(
                   "0127534475" + "\nFSKTM" ",\tFLOOR 12"+ ",\tNO 12" ,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
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
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Constants().BoxShadowColor,
        ),
        dateTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Constants().BoxShadowColor,
        ),
        monthTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Constants().BoxShadowColor,
        ),
        onDateChange: (date){
          setState(() {
            selectedDate = date;  
            print(selectedDate);
          });
        },
       ),
    );
  }

  //function slot
  Widget buildSlot() {
     return Container(
       padding: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.006),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder:  (context, index) {
            return Container(
        
            width: deviceHeight(context) * 0.15,
        
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
                 width: 1,
               color: tappedIndex == index ? Colors.white : Colors.black,
               ), 
            ),  
             child: ListTile(
              title:Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                     Text(
                      slot[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: tappedIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                 ],
                ),
              
              onTap: () {
                setState(() {
                  tappedIndex = index;
                  print(slot[index]);
                });
              },
             ),
            );
          }
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
                  nextScreen(context, UpdateSuccessful());
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
            "Update Book",
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
                    padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical:deviceWidth(context) * 0.05),
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      const Text(
                        "Your Lecturer: ",
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      selectedLecturer(),
                      const SizedBox(height: 30,),
                         const Text(
                        "Number of Students",
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                        TextFormField(    
                            decoration: textInputDecorationNumberStudent.copyWith(
                                hintText: "e.g, 2",
                                fillColor: Color(0xffC0C0C0),
                            ),
                        ),
                        const SizedBox(height: 20,),
                         const Text(
                        "Date",
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      buildDate(),
                       const SizedBox(height: 20,),
                         const Text(
                        "Slot",
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                        SizedBox(height: 20),   
                       SizedBox(height: 50,child: buildSlot()),
             SizedBox(height: 40),       
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
                        
                        dialog();
                    },
                     child:  const Text(
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
                 SizedBox(height: deviceHeight(context) * 0.04,)
                     ],
                    ),
                  ),
              ),
          ),
        ),
     );
   }
  }