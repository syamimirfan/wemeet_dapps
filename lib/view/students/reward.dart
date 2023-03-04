import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Reward",
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

      drawer: MainDrawerStudent(home: false, profile: false, book: false, appointment: false, reward: true, chat: false, yourHistory: false),

      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                 const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
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
                ),
           ),
           child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //for token image
                 Container(
                  padding:EdgeInsets.only(top: deviceWidth(context) * 0.06,) ,
                    child: CircleAvatar(
                      radius: 70,
                   backgroundImage: AssetImage("assets/UTHM_Token.png"),
                  backgroundColor: Colors.white,
                   ),
                 ),

                 //for token value
                 Container(
                   margin: EdgeInsets.only(bottom: deviceHeight(context) * 0.05),
                   child: Text(
                    "12 UTHM",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                   ),
                 ),

                 //for scan qr code button
                SizedBox(
                    width: deviceWidth(context) * 0.5,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                           backgroundColor: Constants().secondaryColor,
                           elevation: 0,
                           padding: const EdgeInsets.symmetric(vertical: 15),
                           shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    onPressed: () {},
                     child: const Text(
                          "Scan QR",
                           style: TextStyle(
                           color: Colors.white,
                           fontFamily: "Poppins",
                           fontSize: 20,
                           fontWeight: FontWeight.w500
                             ),
                           ),
                         ),
                   ),

                //for transactions information
              ],
            ),
           ),
        ),
      ),
    );
  }
}