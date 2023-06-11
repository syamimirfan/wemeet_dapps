import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_reward.dart';
import 'package:wemeet_dapps/constants/connection.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/qr_code.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class RewardToken extends StatefulWidget {
  const RewardToken({super.key});

  @override
  State<RewardToken> createState() => _RewardTokenState();
}

class _RewardTokenState extends State<RewardToken> {

  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  BigInt? token;
  int? nullToken;


  String lectName = "";

  @override
  void initState() {
    super.initState();
    getStudentTokenAddress();
    
  }

  getStudentTokenAddress() async{
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var tokenAddress = _sharedPreferences.getString('tokenAddress');
    getToken(tokenAddress);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                   EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,):
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
                        radius: Device.screenType == ScreenType.tablet? 100 : 70,
                     backgroundImage: AssetImage("assets/UTHM_Token.png"),
                    backgroundColor: Colors.white,
                     ),
                   ),
    
                   //for token value
                   Container(
                     margin: EdgeInsets.only(bottom: deviceHeight(context) * 0.05),
                     child:  Text(
                      token.toString() + "\tUTHM",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize:  Device.screenType == ScreenType.tablet? 30:25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                     ),
                   ),
    
                   //for scan qr code button
                  SizedBox(
                      width: Device.screenType == ScreenType.tablet? deviceWidth(context) * 0.3 : deviceWidth(context) * 0.55,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                             backgroundColor: Constants().secondaryColor,
                             elevation: 0,
                             padding: const EdgeInsets.symmetric(vertical: 15),
                             shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                      onPressed: () {
                          nextScreen(context, QrCode());
                      },
                       child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.h),
                         child: Row(
                           children: [
                            Icon(Icons.qr_code_scanner,color: Colors.white,),
                            SizedBox(width: 2.h,),
                              Expanded(
                         
                                child: Text(
                                "Scan QR",
                                 style: TextStyle(
                                 color: Colors.white,
                                 fontFamily: "Poppins",
                                 fontSize:  22,
                                 fontWeight: FontWeight.w500
                                   ),
                                 ),
                              ),
                           ],
                         ),
                       ),
                           ),
                     ),
                Container(
                  margin: EdgeInsets.only(top: deviceHeight(context) * 0.03,),
                  height: Device.screenType == ScreenType.tablet ? deviceHeight(context) * 0.35 : deviceHeight(context) * 0.45,
                  width: Device.screenType == ScreenType.tablet ? deviceWidth(context) * 0.9 : deviceWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: Constants().primaryColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      "Not Enough SepoliaETH?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: Device.screenType == ScreenType.tablet?18:16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                     ),
                     SizedBox(height: 2.h,),
                          Text(
                              "Browse",
                               textAlign: TextAlign.justify,
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontFamily: 'Poppins',   
                                color: Colors.white                            
                                  ),
                                ),
                               SizedBox(width: deviceWidth(context) * 0.02,),
                                GestureDetector(
                               onTap: () {
                                 launch('https://sepolia-faucet.pk910.de/');
                                 },
                                child: Text(
                                'https://sepolia-faucet.pk910.de/',
                                 style: TextStyle(
                                  fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                 ),
                              ),
                             ),
                            Text(
                              "Or",
                               textAlign: TextAlign.justify,
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                fontFamily: 'Poppins',        
                                color: Colors.white                       
                                  ),
                             ),
                               SizedBox(width: deviceWidth(context) * 0.02,),
                                GestureDetector(
                               onTap: () {
                                 launch('https://sepoliafaucet.com/');
                                 },
                                child: Text(
                                'https://sepoliafaucet.com/',
                                 style: TextStyle(
                                      fontSize: Device.screenType == ScreenType.tablet? 18:15,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                 ),
                              ),
                             ),
                     SizedBox(height: 2.h,),
                            Text(
                                "Not Imported UTHM Token?",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                 fontSize: Device.screenType == ScreenType.tablet? 18:16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                        SizedBox(height: 2.h,),
                          InkWell(
                            child: Container(
                              margin: Device.screenType == ScreenType.tablet?  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.3): EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.17),
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                          Text.rich(
                            TextSpan(
                              text: "0xac60...b413",
                              style: TextStyle(              
                                fontWeight: FontWeight.bold,
                                fontSize: Device.screenType == ScreenType.tablet? 18:16,
                                fontFamily: 'Poppins',
                                color: Colors.black                
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Clipboard.setData(ClipboardData(text: Connection.TOKEN_ADDRESS));
                                 showSnackBarSuccessful(context, "UTHM Token Address copied", Constants().primaryColor);
                              }
                            ),
                          ),
                            IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: Connection.TOKEN_ADDRESS));
                              showSnackBarSuccessful(context, "UTHM Token Address copied", Constants().primaryColor);
                            }, 
                            icon: Icon(Icons.copy, color: const Color(0xff1B1B1B), )
                            ),
                                  ],
                         ),
                        ),
                        onTap: () => {
                            Clipboard.setData(ClipboardData(text: Connection.TOKEN_ADDRESS)),
                           showSnackBarSuccessful(context, "UTHM Token Address copied", Constants().primaryColor)
                        },
                      ),
                    ],
                  ),
                 ),
                ],
              ),
             ),
          ),
        ),
      ),
    );
  }

  //get total token from metamask for student
getToken(String? studentMetamaskAddress) async {
  EasyLoading.show(
    status: "Loading...",
    maskType: EasyLoadingMaskType.black,
  );

  final responseReward = await new Reward().getTotalToken(studentMetamaskAddress!);

  if (responseReward != "null") {
    EasyLoading.dismiss();
    setState(() {
      token = responseReward;
    });
  } else {
    EasyLoading.showError("ERROR!");
  }
}


 //show snackbar 
  void showSnackBarSuccessful(BuildContext context, String content, Color color) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03,vertical:deviceWidth(context) * 0.1),
          backgroundColor: color,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 50, color: Colors.white,),
              SizedBox(width: 5.w,),
              Text(
            content,
            style: TextStyle(
               fontWeight: FontWeight.bold, 
               fontFamily: 'Poppins',
               fontSize: 20,
               color: Colors.white
             ),  
            ),

            ],
          ),
          duration: Duration(seconds: 3),
         ),
      );
  }

     //to view some of lecturer data  
   viewLecturer(String? staffNo) async {
      var responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
      if(responseLecturer['success']) {
         setState(()  {
           lectName = responseLecturer['lecturer'][0]['lecturerName'];
           
         });
      } else {
         throw Exception("Failed to get the data");
      }
  }

  //to make user exit the app if the press back button in the phone
 //use WillPopScope and wrap in Scaffold widget
  Future<bool> _onWillPop() async {
    return  (
      await showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (context) {
                    return  AlertDialog(
                      title:  const Text("Exit App",  
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                        ),
                       ),
                      content: const Text("Do you want exit WeMeet?",
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
                              Navigator.of(context).pop(true);
                              SystemNavigator.pop();
                        }, 
                        icon: const Icon(Icons.done, color: Colors.green,size: 30,)),
                      ],
                    );
                  }
          ));
          
  }


} 