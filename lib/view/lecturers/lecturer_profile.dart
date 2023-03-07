import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/widget/main_drawer_lecturer.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import '../../shared/constants.dart';

class LecturerProfile extends StatefulWidget {
  const LecturerProfile({super.key});

  @override
  State<LecturerProfile> createState() => _LecturerProfileState();
}

class _LecturerProfileState extends State<LecturerProfile> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text(
            "Profile",
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
              onPressed: () => {
                nextScreen(context, About())
              },
               icon:const Icon(Icons.info_outline_rounded),
              ),
          ],
        ),
    drawer: MainDrawerLecturer(home: false, profile: true, slot: false, appointment: false, attendance: false, chat: false),

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
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:  EdgeInsets.only(bottom: 2.0.h),
                        height: 14.0.h,
              
                      decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                     border: Border.all(
                  width: 5,
                  color: Constants().secondaryColor,
                 ),
                     image:  const  DecorationImage(
                       image: AssetImage('assets/lecturer.png'),
                        ),
                       ),
                      ),
                    Form(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:deviceWidth(context) * 0.06),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           //Floor level
                          Text("Floor Level",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "7",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
                       //Room Number
                          Text("Room Number",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "12",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
                          //Academic Qualification 1
                          Text("Academic Qualification 1",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "Academic Qualification 1",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
                         //Academic Qualification 2
                          Text("Academic Qualification 2",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "Academic Qualification 2",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
          
                          //Academic Qualification 3
                          Text("Academic Qualification 3",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "Academic Qualification 3",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
          
                          //Academic Qualification 4
                          Text("Academic Qualification 4",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "Academic Qualification 4",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                         const SizedBox(height: 30,),
          
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
                
                    onPressed: () async{},
                     child:  const Text(
                       "Save",
                       style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                       ),
                     ),
                    ),
                 ),
                        ],
                      ),
                     ),
                    
                    ),
                      const SizedBox(height: 30,),
                   ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}