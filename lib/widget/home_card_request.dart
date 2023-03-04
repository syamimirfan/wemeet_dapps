import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeCard extends StatefulWidget {
  
  const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {


  @override
  Widget build(BuildContext context) {
    return  Container(
        child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          LecturerListTile("assets/lecturer.png","00111","DR. Nur Ariffin Bin Mohd Zin",
          "0127534475"),
            LecturerListTile("assets/icon.png","00111","DR. Zainuri Bin Saringat",
          "0127534475"),
            LecturerListTile("assets/icon.png","00111","DR. Salama A Mostafa",
          "0127534475"),
            LecturerListTile("assets/icon.png","00111","DR. Mazidah Binti Mat Rejab",
          "0127534475"),
            LecturerListTile("assets/icon.png","00111","DR. Noraini Binti Ibrahim",
          "0127534475"),
        ],
      ),
    );
  }

   Widget LecturerListTile(String img, String staffNumber, String name, String phoneNumber) {
      double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
         double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
   
          color: Colors.grey[100],
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin:  const EdgeInsets.only(left: 5),
              child: CircleAvatar(
                backgroundImage: AssetImage(img),
              ),
            ),
            Flexible(

              child: Container(
                margin:  Device.screenType == ScreenType.tablet? 
                         const EdgeInsets.only(left: 20):
                         EdgeInsets.only(left: deviceWidth(context) * 0.03, top: deviceHeight(context) * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      child: Text(
                       staffNumber ,
                        style: TextStyle(
                            fontSize:  Device.screenType == ScreenType.tablet? 
                                        0.18.dp: 0.30.dp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin:   Device.screenType == ScreenType.tablet? 
                         const EdgeInsets.only(bottom: 20):
                         EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                      child: Text(
                        name,
                        style:TextStyle(
                            fontSize: Device.screenType == ScreenType.tablet? 
                                        0.18.dp: 0.28.dp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                   margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        phoneNumber,
                        style: TextStyle(
                            fontSize: Device.screenType == ScreenType.tablet? 
                                        0.18.dp: 0.26.dp,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                        ),
                      ),
                     ),  
                      
                      Container(
                        margin:  Device.screenType == ScreenType.tablet? 
                         const  EdgeInsets.only(top: 10, left:520):
                          EdgeInsets.only(top: 20, left: deviceWidth(context) * 0.3),
                        child: Text.rich(
                          TextSpan(
                            text: "See More",
                                 style:  TextStyle(
                                    color: Constants().secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.underline,
                                    fontSize: 13,
                                 ),
                                 recognizer: TapGestureRecognizer()..onTap = () {
                                 }
                          ),
                        ),
                      ),
                   ],
                ),
                
                ),
            ),
            
          ],
        ),
    );
  }
}