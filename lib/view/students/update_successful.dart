import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/manage_booking.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class UpdateSuccessful extends StatefulWidget {
  const UpdateSuccessful({super.key});

  @override
  State<UpdateSuccessful> createState() => _UpdateSuccessfulState();
}

class _UpdateSuccessfulState extends State<UpdateSuccessful> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
     appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
        ),

        body: Padding(
          padding:Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,),
          child: Container(
              padding:Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.09, horizontal: deviceWidth(context) * 0.06),
            decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    )
              ),
              child: Column(
        
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Image(
                      image: AssetImage("assets/success.gif"),
                      height: 150,
                    ),
                   const Text(
                    "Update Successful",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                   ),
                   SizedBox(height: 5,),
                       const Text(
                    "You have successfully update your appointment",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                   ),
                      SizedBox(height: 20,),
                   Container(
                  padding:Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.02,vertical: deviceHeight(context) * 0.02),
                  height: deviceHeight(context) * 0.35,
                  width: deviceWidth(context) * 0.9,
                    decoration:   BoxDecoration(
                      color: Color(0xffC0C0C0),
                      borderRadius: BorderRadius.circular(10)
                       ),  
                      child: Column(
    
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          SizedBox(width: 20,),
                          const Text(
                          "Your Appointment Details:",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                            SizedBox(height: 10,),
                               
                          const Text(
                          "Dr Nur Ariffin Bin Mohd Zin",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                                 SizedBox(height: 5,),
                          const Text(
                          "1 students",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                                  SizedBox(height: 5,),
                          const Text(
                          "26 JAN 2023:",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                           SizedBox(height: 5,),
                           Text(
                          "10.00 AM",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Constants().secondaryColor,
                          ),
                        ),
                          SizedBox(height: 20),       
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().secondaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),

                      ),
                
                    onPressed: () async{
                      nextScreen(context, ManageBooking());
                    },
                     child:  const Text(
                       "Go to Appointment",
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
                ],
              ),
          ),
        ),
    );
  }
}