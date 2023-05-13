import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_reward.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/qr_code.dart';
import 'package:wemeet_dapps/widget/main_drawer_student.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:web3dart/web3dart.dart';

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
                   child:  Text(
                    token.toString() + "\tUTHM",
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
                    onPressed: () {
                        nextScreen(context, QrCode());
                    },
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
              Container(
                margin: EdgeInsets.only(top: deviceHeight(context) * 0.03, bottom: deviceHeight(context) * 0.03),
                child: Column(
                  children: [
                    Text(
                    "Not Enough SepoliaETH?",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                   ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [ 
                            Text(
                            "Click",
                             textAlign: TextAlign.justify,
                              style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontFamily: 'Poppins',                               
                                ),
                              ),
                             SizedBox(width: deviceWidth(context) * 0.02,),
                              GestureDetector(
                             onTap: () {
                               launch('https://sepolia-faucet.pk910.de/');
                               },
                              child: Text(
                              'https://goerli-faucet.pk910.de/',
                               style: TextStyle(
                                fontSize: 22,
                                color: Constants().primaryColor,
                                decoration: TextDecoration.underline,
                               ),
                            ),
                           ),
                          Text(
                            "Or",
                             textAlign: TextAlign.justify,
                              style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontFamily: 'Poppins',                               
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
                                fontSize: 22,
                                color: Constants().primaryColor,
                                decoration: TextDecoration.underline,
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
           ),
        ),
      ),
    );
  }

  //get total token from metamask for student
  getToken(String? studentMetamaskAddress) async {
  final responseReward = await new Reward().getTotalToken(studentMetamaskAddress!);
  setState(() {
    token = responseReward;
  });
}
} 