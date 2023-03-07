import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class Slot extends StatefulWidget {
  const Slot({super.key});

  @override
  State<Slot> createState() => _SlotState();
}

class _SlotState extends State<Slot> {

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];
  String daysValue = "Sunday";
  String slot1 = "8.00 AM";
  String slot2 = "10.00 AM";
  String slot3 = "12.00 PM";
  String slot4 = "2.00 PM";
  String slot5 = "4.00 PM";
  
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isInfo = false;
  bool isShowOpen = false;
  bool isAdd = false;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
       title: const Text(
          "Slot",
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
            icon: const Icon(Icons.info_outline_rounded),
            ),
        ],
      ),
      drawer: MainDrawerLecturer(home: false, profile: false, slot: true, appointment: false, attendance: false, chat: false),

      body: Padding(
           padding: Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
               color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
               ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.012),
                      child: const Text(
                        "Your Schedule",
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03, vertical: deviceHeight(context) * 0.01),
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.009),
        
                      child: DataTable(
                        columnSpacing: deviceWidth(context) * 0.04,
                        headingTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Colors.white),
                        dataTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Colors.black),
                        headingRowColor: MaterialStateProperty.all<Color>(Constants().secondaryColor),
                        dataRowColor: MaterialStateProperty.all<Color>(Constants().dividerColor),
                        dividerThickness: 1,
                        columns: [
                          DataColumn(label: Text("Day/Slot")),
                          DataColumn(label: Text("S1",)),
                          DataColumn(label: Text("S2"),),
                          DataColumn(label: Text("S3",)),
                          DataColumn(label: Text("S4",)),
                          DataColumn(label: Text("S5",)),
                        ], 
                        rows: [
                           DataRow(cells: [
                            DataCell(Text("Sunday")),
                            DataCell(Text("8.00 AM")),
                            DataCell(Text("10.00 AM")),
                            DataCell(Text("12.00 PM")),
                            DataCell(Text("")),
                            DataCell(Text("")),
                           ]),
                            DataRow(cells: [
                            DataCell(Text("Monday")),
                            DataCell(Text("8.00 AM")),
                            DataCell(Text("10.00 AM")),
                            DataCell(Text("12.00 PM")),
                            DataCell(Text("2.00 PM")),
                            DataCell(Text("4.00 PM")),
                           ]),
                             DataRow(cells: [
                            DataCell(Text("Tuesday")),
                            DataCell(Text("8.00 AM")),
                            DataCell(Text("10.00 AM")),
                            DataCell(Text("12.00 PM")),
                            DataCell(Text("2.00 PM")),
                            DataCell(Text("4.00 PM")),
                           ]),
                             DataRow(cells: [
                            DataCell(Text("Wednesday")),
                            DataCell(Text("8.00 AM")),
                            DataCell(Text("10.00 AM")),
                            DataCell(Text("12.00 PM")),
                            DataCell(Text("2.00 PM")),
                            DataCell(Text("4.00 PM")),
                           ]),
                             DataRow(cells: [
                            DataCell(Text("Thursday")),
                           DataCell(Text("8.00 AM")),
                            DataCell(Text("10.00 AM")),
                            DataCell(Text("12.00 PM")),
                            DataCell(Text("2.00 PM")),
                            DataCell(Text("4.00 PM")),
                           ]),
                        ],
                      ),
                    ),

                      Container(
                       margin: EdgeInsets.only(bottom: deviceHeight(context) * 0.02),
                       padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05),
                        child: 
                        Row(
                          children: [ 
                           Text(
                           "Please be noted that",
                           style: TextStyle(
                           fontFamily: 'Poppins', 
                           fontSize: Device.screenType == ScreenType.tablet? 0.18.dp: 0.30.dp,
                           fontWeight: FontWeight.w700,
                           color: Colors.black
                           ),
                          ),  
                          
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isInfo = true;
                                if(isShowOpen) {
                                  isInfo = false;
                                  isShowOpen = false;
                                }
                              });
                            }, 
                            icon: Icon(Icons.info_sharp, color: Constants().secondaryColor, size: Device.screenType == ScreenType.tablet? 0.18.dp: 0.4.dp,)
                            ),
                            Text.rich(
                      TextSpan(
                     text: "Help",
                     style:   TextStyle(
                       color: Constants().secondaryColor,
                       fontSize:  Device.screenType == ScreenType.tablet? 0.18.dp: 0.30.dp,
                       fontWeight: FontWeight.bold,
                       fontFamily: 'Poppins',
                     ),
                     recognizer: TapGestureRecognizer()..onTap = () {
                           setState(() {
                                isInfo = true;
                                if(isShowOpen) {
                                  isInfo = false;
                                  isShowOpen = false;
                                }
                              });
                        }
                       ),
                      ),
                          
                         ],
                        ),            
                      ),     
                      if(isInfo) showHelp(),
                          //for button add slot and update slot
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().secondaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAdd = true;
                                        });
                                      },
                                      child: const Text(
                                        "Add Slot",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                                   SizedBox(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isUpdate = true;
                                        });
                                      },
                                      child: const Text(
                                        "Update Slot",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                              ],
                        ), 
                     if(isAdd ) addSlot(),
                     if(isUpdate ) updateSlot()
                     
                  ],
              ),
            ),
          ),
      ),
    );
  }

  //info for appropriate actions function
   Widget showHelp() {
    setState(() {
      isShowOpen = true;
    });
     return Container(
         margin: EdgeInsets.only(left: deviceWidth(context) * 0.03, right: deviceWidth(context) * 0.03, bottom: deviceHeight(context) * 0.05),
          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.02),
           decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
             color: Colors.white,
             border: Border.all(
              color: Constants().BoxShadowColor,
             ),
              boxShadow:  [
           BoxShadow(
           color: Constants().BoxShadowColor,
            offset: const Offset(0, 10),
             blurRadius: 15,
           spreadRadius: 0,
            ),
       ],
    ),
       child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_sharp, color: Constants().secondaryColor, size: 25,),
                      SizedBox(width: deviceWidth(context) * 0.02,),
                      Text("INFORMATION: ADD SLOT", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: deviceHeight(context) * 0.01,),
                  Text("1. Please add your slot.", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  Text("2. Please enter your free time to set the appointment with student based on your schedule for this semester.",style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  Text("3. Button add will be disable if everyday has been set.", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: deviceHeight(context) * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_sharp, color: Constants().primaryColor, size: 25,),
                      SizedBox(width: deviceWidth(context) * 0.01,),
                      Text("INFORMATION: UPDATE SLOT", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ), 
                  SizedBox(height: deviceHeight(context) * 0.01,),
                  Text("1. Update your slot with certain day.", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  Text("2. Please enter the day and new slot you want to update for the appointment.",style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
               ],
             ),
     );
  }

  //function for button add slot
  Widget addSlot() {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05, vertical: deviceHeight(context) * 0.05), 
       padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.2, vertical: deviceHeight(context) * 0.02),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          color: Colors.white,
           border: Border.all(
              color: Constants().BoxShadowColor,
             ),
              boxShadow:  [
             BoxShadow(
              color: Constants().BoxShadowColor,
              offset: const Offset(0, 10),
               blurRadius: 15,
               spreadRadius: 0,
              ),
            ],
          ),
       child: Column(
         children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Text("Add",style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Constants().secondaryColor),),
                SizedBox(width: deviceWidth(context) * 0.01,),
                Text("Slot",style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
            ],),
            SizedBox(height: deviceHeight(context) * 0.03,),
            Form(
              key: _globalKey,
              child: Column(
                children: [ Row(
                children: [
                const Text("Day: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(width: deviceWidth(context) * 0.1,),
                DropdownButton<String>(
                focusColor: Colors.black,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15),
                hint: const Text("Select Day",style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15), ),
                items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(), 
                 onChanged: (String? newValue) {
                 setState(() {
                   daysValue = newValue ?? '';
                 });
                 print(daysValue);
                  }
                ),
                ],
               ),
               SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 1: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked1, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked1 = newChecked!;
                          if(isChecked1) {
                          print(slot1);
                          }
                        });       
                    }),
             
                     Text(slot1,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 2: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked2, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked2 = newChecked!;
                          if(isChecked2) {
                          print(slot2);
                          }
                        });       
                    }),
             
                   Text(slot2,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 3: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked3, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked3 = newChecked!;
                          if(isChecked3) {
                          print(slot3);
                          }
                        });       
                    }),
             
                     Text(slot3,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 4: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked4, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked4 = newChecked!;
                          if(isChecked4) {
                          print(slot4);
                          }
                        });       
                    }),
             
                     Text(slot4,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 5: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked5, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked5 = newChecked!;
                          if(isChecked5) {
                          print(slot5);
                          }
                        });       
                    }),
                   Text(slot5,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
                 ),
                  SizedBox(height: deviceHeight(context) * 0.02,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                   child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(color: Colors.black, width: 1),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAdd = false;
                                        });
                                      },
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                                   SizedBox(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:Constants().secondaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        
                                      },
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                              ],
                        ), 
                 ],
              ),
          ),
         ],
       ),
     );
  }
  
  //function for button update slot
  Widget updateSlot() {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05, vertical: deviceHeight(context) * 0.05), 
       padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.2, vertical: deviceHeight(context) * 0.02),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          color: Colors.white,
           border: Border.all(
              color: Constants().BoxShadowColor,
             ),
              boxShadow:  [
             BoxShadow(
              color: Constants().BoxShadowColor,
              offset: const Offset(0, 10),
               blurRadius: 15,
               spreadRadius: 0,
              ),
            ],
          ),
       child: Column(
         children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Text("Update",style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Constants().primaryColor),),
                SizedBox(width: deviceWidth(context) * 0.01,),
                Text("Slot",style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
            ],),
            SizedBox(height: deviceHeight(context) * 0.03,),
            Form(
              key: _globalKey,
              child: Column(
                children: [ Row(
                children: [
                const Text("Day: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(width: deviceWidth(context) * 0.1,),
                DropdownButton<String>(
                focusColor: Colors.black,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15),
                hint: const Text("Select Day",style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15), ),
                items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(), 
                 onChanged: (String? newValue) {
                 setState(() {
                   daysValue = newValue ?? '';
                 });
                 print(daysValue);
                  }
                ),
                ],
               ),
               SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 1: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked1, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked1 = newChecked!;
                          if(isChecked1) {
                          print(slot1);
                          }
                        });       
                    }),
             
                     Text(slot1,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 2: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked2, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked2 = newChecked!;
                          if(isChecked2) {
                          print(slot2);
                          }
                        });       
                    }),
             
                   Text(slot2,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 3: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked3, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked3 = newChecked!;
                          if(isChecked3) {
                          print(slot3);
                          }
                        });       
                    }),
             
                     Text(slot3,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 4: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked4, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked4 = newChecked!;
                          if(isChecked4) {
                          print(slot4);
                          }
                        });       
                    }),
             
                     Text(slot4,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    const Text("Slot 5: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked5, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked5 = newChecked!;
                          if(isChecked5) {
                          print(slot5);
                          }
                        });       
                    }),
                   Text(slot5,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),
                  ],
                 ),
                  SizedBox(height: deviceHeight(context) * 0.02,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SizedBox(
                             child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.white,
                             side: BorderSide(color: Colors.black, width: 1),
                             elevation: 0,
                            shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                                   ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isUpdate = false;
                                        });
                                      },
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                                   SizedBox(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        
                                      },
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                              ],
                        ), 
                ],
              ),
          ),
         ],
       ),
     );
  }
      
}