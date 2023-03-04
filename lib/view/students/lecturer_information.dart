import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/shared/constants.dart';

class LecturerInformation extends StatefulWidget {
  const LecturerInformation({super.key});

  @override
  State<LecturerInformation> createState() => _LecturerInformationState();
}

class _LecturerInformationState extends State<LecturerInformation> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.001),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //first row (picture, staffNo and so on)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.03, horizontal: deviceWidth(context) *0.01),
                           //for lecturer images
                            child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/lecturer.png"),
                          ),
                        ),

                        SizedBox(width: 20,),
                        //for lecturer basic information
                         Flexible(
                                child: Container(
                                  // margin: Device.screenType == ScreenType.tablet? 
                                  //         const EdgeInsets.only(left: 20) :
                                  //         EdgeInsets.only(left: deviceWidth(context) * 0.02, top: deviceHeight(context) * 0.02),
                                  padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.04, horizontal: deviceWidth(context) *0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                            "00011",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                              0.22.dp: 0.32.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                        ),
                                        Container(
                                          margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "0127534475",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                             0.22.dp: 0.32.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                        ),
                                        Container( 
                                           margin: Device.screenType == ScreenType.tablet? 
                                              const EdgeInsets.only(bottom: 20):
                                              EdgeInsets.only(bottom: deviceWidth(context) * 0.01) ,
                                            child: Text(
                                              "FSKTM, LEVEL 7, NO 12",
                                              style:TextStyle(
                                                  fontSize: Device.screenType == ScreenType.tablet? 
                                                              0.22.dp: 0.32.dp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                              ),
                                            ),
                                        ),
                                   
                                    ],
                                  ),
                                )
                               ),
                        ],
                     ),
                    //for lecturer name
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                      child:  Text(
                        "DR NUR ARIFFIN BIN MOHD ZIN",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //for divider between basic information and academic information
                     Container(
                      padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05),
                      child:  Divider(
                      color: Constants().dividerColor,
                      thickness: 2,
                     ),
                    ),

                    //for department
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                    child: Text(
                      "Jabatan Kejuruteraan Perisian",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.center,
                    ),
                  ),

                  //for academic qualification title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      padding:  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.06),
                      child: Text(
                      "Academic Qualification",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), 
                       ),
                      ),
                    ],
                  ),

                  //for academic qualification content
                  Column(
                    children: [
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015),
                        child: Text(
                      "DIPLOMA TELEKOMUNIKASI , KOLEJ UNIVERSITI TEKNOLOGI TUN HUSSEIN ONN (2005)",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.justify,
                       ),
                      ),
                            Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                        child: Text(
                      "SARJANA MUDA SAINS KOMPUTER , UNIVERSITI TEKNOLOGI MALAYSIA (2009)",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.justify,
                       ),
                      ),
                            Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                        child: Text(
                      "SARJANA SAINS KOMPUTER , UNIVERSITI KEBANGSAAN MALAYSIA (2013)",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.justify,
                       ),
                      ),
                            Container(
                        padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.015, vertical: deviceHeight(context) * 0.02),
                        child: Text(
                      "DOKTOR FALSAFAH SAINS KOMPUTER , UNIVERSITI TEKNOLOGI MALAYSIA (2020)",
                       style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ), 
                        textAlign: TextAlign.justify,
                       ),
                      ),
                    ],
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}