import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/widget/home_card.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';


class HomeStudents extends StatefulWidget {
  const HomeStudents({super.key});

  @override
  State<HomeStudents> createState() => _HomeStudentsState();
}

class _HomeStudentsState extends State<HomeStudents> {
  @override
  Widget build(BuildContext context) {
      double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
      double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "Home",
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
drawer: MainDrawerStudent(home: true, profile: false, book: false, appointment: false, reward: false, chat: false, yourHistory: false),
       
       body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Padding(
                  padding: Device.screenType == ScreenType.tablet?  
                    const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.09,),
                  child:  Container(
                    child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                    Text(
                  "Hello, ",
                   style: TextStyle(
                    color: Colors.white,
                    fontSize: Device.screenType == ScreenType.tablet? 
                              0.20.dp:0.32.dp,
                    fontFamily: 'Poppins',
                   ),
                ),
                  ]),
                  ),
                ),
                     
                 Padding(
                  padding:  Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.09,),
                   child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children:  [
                         const SizedBox(height: 40,),
                     Flexible(
                      child: Text(
                      "MUHAMAD SYAMIM IRFAN BIN AHMAD SHOKKRI",
                       style: TextStyle(
                       color: Colors.white,
                       fontSize:  Device.screenType == ScreenType.tablet?  
                                  0.18.dp: 0.26.dp,  
                       fontWeight: FontWeight.bold,
                       fontFamily: 'Poppins',
                         ),
                       ),
                     ),
                      SizedBox(width: deviceWidth(context) * 0.07,),
                        Icon(Icons.waving_hand, color: const Color(0xFFFFDD67), size:Device.screenType == ScreenType.tablet?  0.2.dp: 0.4.dp,),
                    ],
                   ),
                 ),
                   const SizedBox(height: 20,),
         
                   Padding(
                  padding: Device.screenType == ScreenType.tablet?  
                   const EdgeInsets.symmetric(horizontal: 40,):
                   const EdgeInsets.symmetric(horizontal: 30,),
                  child: Container(
                    child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(
                  "Welcome Back",
                   style: TextStyle(
                    color: Colors.white,
                    fontSize:  Device.screenType == ScreenType.tablet?  
                               0.30.dp:0.40.dp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                   ),
                ),
                  ]),
                  ),
                ),
            
                const SizedBox(height: 30,),
                
                Flexible(
                  child: Container(
                      decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                       )
                      ),
                     height: Device.screenType == ScreenType.tablet?  849: deviceHeight(context) * 100,
                     width: Device.screenType == ScreenType.tablet?  1000: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: const EdgeInsets.only(top: 20,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                               const Text(
                                "Lecturer Information",
                               style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                               ),
                              ),
                            
                               HomeCard(),
                               SizedBox(height: deviceHeight(context) * 0.03,)
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ],
             ),
           ),
    );
  }
}