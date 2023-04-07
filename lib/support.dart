import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wemeet_dapps/shared/constants.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "WeMeet Support",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: Device.screenType == ScreenType.tablet? 
                  const EdgeInsets.symmetric(vertical: 10,horizontal: 42,):
                       EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.01,),
             child: Container(
                      decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                       BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                       )
                      ),
                     height: Device.screenType == ScreenType.tablet?  849: deviceHeight(context) * 3,
                     width: Device.screenType == ScreenType.tablet?  1000: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) *0.07),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                          SizedBox(height: deviceHeight(context) * 0.03,),
                          Image.asset('assets/UTHM2.png'),
                          SizedBox(height: deviceHeight(context) * 0.02,),
                           Container(
                            padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.08),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  const Text(
                                  "Metamask",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 1  : Download Metamask on Play Store.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                   const Text(
                                  "Step 2 : Register your account. ",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 3 : Please make a Secret Recovery Phrase (Your Secret Recovery Phrase is very important, Please remember or write it somewhere. You need to fill the phrase if you want to login the Metamask account).",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                    ),
                                    ),
                                     SizedBox(height: deviceHeight(context) * 0.04,),
                                   Text(
                                  "NOTE! Please make sure you have enough GoerliETH Token to make transaction! Otherwise, you cannot make a transaction with seller. (i.e make sure earn more than 0 GoerliETH)",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Constants().secondaryColor
                                     ),
                                    ),
                                     Row(
                                      children: [ 
                                      Text(
                                      "Click",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',                               
                                        ),
                                        ),
                                        SizedBox(width: deviceWidth(context) * 0.02,),
                                    GestureDetector(
                                        onTap: () {
                                          launch('https://goerli-faucet.pk910.de/');
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
                                    ],
                                     ),
                                      Text(
                                      "Copy your Metamask Account Address and pass it to get free 0.2 GoerliETH",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',                               
                                        ),
                                        ),
                                        Text(
                                      "Everyday!",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',   
                                      color: Constants().secondaryColor                            
                                        ),
                                        ),
                                      SizedBox(height: deviceHeight(context) * 0.04,),
                                    const Text(
                                  "Import UTHM Token",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                     ),
                                    ),
                                      const  Text(
                                  "Step 1  : Copy the token address from popup dialog. e.g , 0x77B9B0ace19fe2Ec236679e94f9a3cDbC507D30B",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 2 : Open Metamask App and login with your password.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 3 : Change Ethereum Main Network to Goerli Test Network.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 4 : Click “Import Tokens”.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                  const  Text(
                                  "Step 5 : Paste the copied token address in Token Address textbox (It will automatically fill in the Token Symbol and Token Decimal).",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
                                    ),
                                      const  Text(
                                  "Step 6 : Press “IMPORT” button and you ready to go.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                 ),
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
}