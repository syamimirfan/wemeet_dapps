import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_booking.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
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
  final GlobalKey<FormState> _globalKey2 = GlobalKey<FormState>();
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];
  String daysValue = "Sunday";
  bool dayIsChecked = false;
  String slot1 = "";
  String slot2 = "";
  String slot3 = "";
  String slot4 = "";
  String slot5 = "";
  String slot6 = "";
  String slot7 = "";
  String slot8 = "";
  String slot9 = "";
  String slot10 = "";

  
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;
  bool isChecked10 = false;
  bool isInfo = false;
  bool isShowOpen = false;
  bool isAdd = false;
  bool isUpdate = false;
  
  String daySet = "";
  String slotOne = "";
  String slotTwo = "";
  String slotThree = "";
  String slotFour = "";
  String slotFive = "";

  String studentName = "";
  String studentNameBookingUpdate = "";

  List<dynamic> data = [];
 
  @override
  void initState() { 
    super.initState();
    getSlot();
  }

  void getSlot() async{

      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      var staffNo = _sharedPreferences.getString('staffNo');

      viewSlot(staffNo);
      getAppointment(staffNo);
      
  } 

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
                    EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
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
                      child:  Text(
                        "Your Schedule",
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize:  Device.screenType == ScreenType.tablet? 20:20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03, vertical: deviceHeight(context) * 0.01),
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.009),
        
                      child: DataTable(
                        columnSpacing: Device.screenType == ScreenType.tablet? deviceWidth(context) * 0.06 : deviceWidth(context) * 0.04,
                        headingTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Colors.white),
                        dataTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Colors.black),
                        headingRowColor: MaterialStateProperty.all<Color>(Constants().secondaryColor),
                        dataRowColor: MaterialStateProperty.all<Color>(Constants().dividerColor),
                        dividerThickness: 1,
                        columns: [
                          DataColumn(label: Text("Day/Slot")),
                          DataColumn(label: Text("S1",)),
                          DataColumn(label: Text("S2",),),
                          DataColumn(label: Text("S3",)),
                          DataColumn(label: Text("S4",)),
                          DataColumn(label: Text("S5",)),
                        ], 
                        rows: data.isNotEmpty? data.map((slotSet) {
                          return DataRow(cells: [
                            DataCell(Text(slotSet['day'] ?? '')),
                            DataCell(Text(slotSet['slot1'] ?? '')),
                            DataCell(Text(slotSet['slot2'] ?? '')),
                            DataCell(Text(slotSet['slot3'] ?? '')),
                            DataCell(Text(slotSet['slot4'] ?? '')),
                            DataCell(Text(slotSet['slot5'] ?? '')),
                          ]);
                        }).toList() :[
                            DataRow(
                              cells: [
                                DataCell(Container(
                                  child: Text(""),
                                )),
                                 DataCell(Container(
                                  child: Text(""),
                                )),
                                 DataCell(Container(
                                  child: Text(""),
                                )),
                                 DataCell(Container(
                                  child: Text(""),
                                )),
                                 DataCell(Container(
                                  child: Text(""),
                                )),
                                 DataCell(Container(
                                  child: Text(""),
                                )),
                              ]
                            )
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
                           fontSize: Device.screenType == ScreenType.tablet? 20:17,
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
                            icon: Icon(Icons.info_sharp, color: Constants().secondaryColor, size: Device.screenType == ScreenType.tablet? 0.17.dp: 0.4.dp,)
                            ),
                            Text.rich(
                      TextSpan(
                     text: "Help",
                     style:   TextStyle(
                       color: Constants().secondaryColor,
                       fontSize:  Device.screenType == ScreenType.tablet? 20:17,
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
                                      onPressed: data.length >= 5 ? null : () {
                                        setState(() {
                                          isAdd = true;
                                        });
                                      },
                                      child: Text(
                                        "Add Slot",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Device.screenType == ScreenType.tablet? 20:17,
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
                                      onPressed: data.length < 5 ? null : () {
                                        setState(() {
                                          isUpdate = true;
                                        });
                                      },
                                      child: Text(
                                        "Update Slot",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Device.screenType == ScreenType.tablet?20:17,
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
                   Text("3. No duplicate day allowed.",style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  Text("4. Button add slot will be disable if 5 work days has been inserted.", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
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
                  Text("2. Please choose the day and new slot you want to update for the appointment.",style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                  Text("3. Button update slot will be enable after lecturer add 5 work days of appointment.",style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
               ],
             ),
     );
  }

  //function for button add slot
  Widget addSlot() {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05, vertical: deviceHeight(context) * 0.05), 
       padding: Device.screenType == ScreenType.tablet ?  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.26, vertical: deviceHeight(context) * 0.02) : EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.2, vertical: deviceHeight(context) * 0.02),
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
            Text("Add Slot",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:20, fontWeight: FontWeight.bold, color: Colors.black),),
            SizedBox(height: deviceHeight(context) * 0.03,),
            Form(
              key: _globalKey,
              child: Column(
                children: [ Row(
                children: [
                 Text("Day: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                 SizedBox(width:  Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.15 : deviceWidth(context) * 0.1,),
                DropdownButton<String>(
                focusColor: Colors.black,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize:  Device.screenType == ScreenType.tablet? 18:15),
                hint:  dayIsChecked ? Text(daysValue,style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: Device.screenType == ScreenType.tablet? 0.14.dp : 0.28.dp), ):  Text("Select Day",style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15), ),
                items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(), 
                 onChanged: (String? newValue) async {
                 setState(() {
                   daysValue = newValue ?? '';
                   dayIsChecked = true;
                 });
            
                  }
                ),
                ],
               ),
               SizedBox(height: deviceHeight(context) * 0.02,),
               
               Row(
                  children: [
                     Text("Slot 1: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked1, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (bool? newChecked) {
                        setState(() {
                          isChecked1 = newChecked!;
                          slot1 = isChecked1 ? "8.00 AM" : "";
                        });       
                    }),
             
                     Text("8.00 AM",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                     Text("Slot 2: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked2, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (bool? newChecked) {
                        setState(() {
                          isChecked2 = newChecked!;
                          slot2 = isChecked2 ? "10.00 AM" : "";
                        });       
                    }),
             
                   Text("10.00 AM",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    Text("Slot 3: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked3, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (bool? newChecked) {
                        setState(() {
                          isChecked3 = newChecked!;
                          slot3 = isChecked3 ? "12.00 PM" : "";
                        });       
                    }),
             
                     Text("12.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                    Text("Slot 4: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked4, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (bool? newChecked) {
                        setState(() {
                          isChecked4 = newChecked!;
                          slot4 = isChecked4 ? "2.00 PM" : "";
                        });       
                    }),
             
                     Text("2.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                     SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                   Text("Slot 5: ",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked5, 
                    activeColor: Constants().secondaryColor,
                    onChanged: (bool ?newChecked) {
                        setState(() {
                          isChecked5 = newChecked!;
                          slot5 = isChecked5 ? "4.00 PM" : "";
                        });       
                    }),
                   Text("4.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize:  Device.screenType == ScreenType.tablet? 18:15, ),),
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
                                      child:  Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize:  Device.screenType == ScreenType.tablet? 18:15,
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
                    
                                      onPressed: () async{
                                        final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                                        var staffNo = _sharedPreferences.getString('staffNo');
              
                                        slot(staffNo!, daysValue, slot1, slot2, slot3, slot4, slot5);
  
                                      },
                                      child:  Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize:  Device.screenType == ScreenType.tablet? 18:15,
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
       margin:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05, vertical: deviceHeight(context) * 0.05), 
       padding: Device.screenType == ScreenType.tablet ?  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.26, vertical: deviceHeight(context) * 0.02) : EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.2, vertical: deviceHeight(context) * 0.02),
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

            Text("Update Slot",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:20, fontWeight: FontWeight.bold, color: Colors.black),),

            SizedBox(height: deviceHeight(context) * 0.03,),
            Form(
              key: _globalKey2,
              child: Column(
                children: [ Row(
                children: [
                Text("Day: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                SizedBox(width:  Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.15 : deviceWidth(context) * 0.1,),
                 DropdownButton<String>(
                focusColor: Colors.black,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize:  Device.screenType == ScreenType.tablet? 18:15),
                hint:  dayIsChecked ? Text(daysValue,style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: Device.screenType == ScreenType.tablet? 18:15,), ):  Text("Select Day",style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15), ),
                items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(), 
                 onChanged: (String? newValue) async {
                 setState(() {
                   daysValue = newValue ?? '';
                   dayIsChecked = true;
                 });
            
                  }
                ),
                ],
               ),
               SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                   Text("Slot 1: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked6, 
                    activeColor: Constants().primaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked6 = newChecked!;
                          slot6 = isChecked6 ? "8.00 AM" : "";
                        });       
                    }),
             
                     Text("8.00 AM",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                     Text("Slot 2: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked7, 
                    activeColor: Constants().primaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked7 = newChecked!;
                          slot7 = isChecked7 ? "10.00 AM" : "";
                        });       
                    }),
             
                   Text("10.00 AM",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                      SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                     Text("Slot 3: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked8, 
                    activeColor: Constants().primaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked8 = newChecked!;
                          slot8 = isChecked8 ? "12.00 PM" : "";
                        });       
                    }),
             
                     Text("12.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                      SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                     Text("Slot 4: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked9, 
                    activeColor: Constants().primaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked9 = newChecked!;
                          slot9 = isChecked9 ? "2.00 PM" : "";
                        });       
                    }),
             
                     Text("2.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, ),),
                  ],
               ),
                             SizedBox(height: deviceHeight(context) * 0.02,),
               Row(
                  children: [
                     Text("Slot 5: ",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, fontWeight: FontWeight.bold),),
                    SizedBox(width: Device.screenType == ScreenType.tablet ?  deviceWidth(context) * 0.13 : deviceWidth(context) * 0.06,),
                    Checkbox(
                    value: isChecked10, 
                    activeColor: Constants().primaryColor,
                    onChanged: (newChecked) {
                        setState(() {
                          isChecked10 = newChecked!;  
                          slot10 = isChecked10 ? "4.00 PM" : "";
                        });       
                    }),
                   Text("4.00 PM",style: TextStyle(fontFamily: 'Poppins', fontSize: Device.screenType == ScreenType.tablet? 18:15, ),),
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
                                      child:  Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                            fontFamily: 'Poppins',
                                        ),
                                      ),
                                  ),
                                ),
                                   SizedBox(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants().secondaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () async{
                                        final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
                                        var staffNo = _sharedPreferences.getString('staffNo');
              
                                        editSlot(staffNo!, daysValue, slot6, slot7, slot8, slot9, slot10);
                                      },
                                      child:  Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Device.screenType == ScreenType.tablet? 18:15,
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

  //function to add slot
  slot(String staffNo, String day, String slot1, String slot2, String slot3, String slot4, String slot5) async{
      final responseBooking = await new Booking().addSlot(staffNo, day, slot1, slot2, slot3, slot4, slot5);

      if(responseBooking['success']) {
         if(responseBooking['message'] == "Slot already exists") {
          showMessage(context, "No Day Duplicate", "Cannot add the duplicate day for slot", "OK",false);
         }else {
          showMessage(context, "Slot Added", "Your slot has successfully added", "OK",false);
         }
      }else {
          showMessage(context, "Ooops!", "Cannot add the slot", "OK", false);
        throw Exception("Failed to upload data");
      }
  } 

  //function to update slot
  editSlot(String staffNo, String day, String slot1, String slot2, String slot3, String slot4, String slot5) async {
    final responseBooking = await new Booking().updateSlot(staffNo, day, slot1, slot2, slot3, slot4, slot5);
    if(responseBooking['success']) {
      showMessage(context, "Slot Updated", "Your slot for ${day} has been updated!", "OK", true);
    }else {
         showMessage(context, "Ooops!", "Cannot update slot for ${day} ", "OK", true);
    }
}

  //function to get slot
   viewSlot(String? staffNo) async {
     final responseBooking  = await new Booking().getSlotDetail(staffNo!);

    if (responseBooking['success']) {
     final responseData = responseBooking['slot'];
        if (responseData is List) {
         setState(() {
        data = responseData;
        });
      }
    } else {
     print('Error fetching data: ${responseBooking['message']}');
   }
  }

  //to get notification message from student
  getMessage(String? matricNo, String? staffNo) async {
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

       //to view some of student data
    viewStudent(String? matricNo) async {
      var responseStudent = await new Student().getStudentDetail(matricNo!);
      if(responseStudent['success']) {
         setState(()  {
           studentName = responseStudent['student'][0]['studName'];
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
            .showNotification(title: "New Appointment" ,body: studentName + " has book an appointment session with you").then((value) => {
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
    
  //show message box function
  static void showMessage(BuildContext context, String title, String message, String buttonText, bool action) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
           content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
           actions: [ 
              ElevatedButton(
                onPressed: () {
                 nextScreenReplacement(context, Slot());
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: action ? MaterialStateProperty.all<Color>(Constants().primaryColor) : MaterialStateProperty.all<Color>(Constants().secondaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
  }
}
