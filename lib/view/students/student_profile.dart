import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import '../../shared/constants.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {

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
    drawer: MainDrawerStudent(home: false, profile: true, book: false, appointment: false, reward: false, chat: false, yourHistory: false),

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
                       image: AssetImage('assets/student.png'),
                        ),
                       ),
                      ),
                    Form(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:deviceWidth(context) * 0.06),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name 
                          Text("Name",
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
                                hintText: "Muhamad Syamim Irfan Bin Ahmad Shokkri",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                             const SizedBox(height: 10,),
                           //matric number
                          Text("Matric Number",
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
                                hintText: "AI200104",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),
                            const SizedBox(height: 10,),
                           //telephone number 
                          Text("Telephone Number",
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
                                hintText: "0194078581",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),
                            const SizedBox(height: 10,),   
                           //email 
                          Text("Email",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.30.dp,
                            fontFamily: 'Poppins',
                          ),
                          ),
                          TextFormField(    
                            decoration: textInputDecorationMain.copyWith(
                                hintText: "syamimirfan59@gmail.com",
                                fillColor: Color(0xffC0C0C0),
                            ),
                          ),   
                            const SizedBox(height: 10,),
                           //metamask account address
                          Text("Metamask Account Address",
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
                                hintText: "0xDe9D80fC9aCf342D4E0C30593aFBf6a55821f422",
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