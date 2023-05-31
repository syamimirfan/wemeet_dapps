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
                     EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001, vertical: deviceHeight(context) * 0.001):
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
                     height: Device.screenType == ScreenType.tablet?  deviceHeight(context) * 3: deviceHeight(context) * 3,
                     width: Device.screenType == ScreenType.tablet?  deviceWidth(context) * 3: deviceWidth(context) * 3, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) *0.07),
                          child: Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                            SizedBox(height: deviceHeight(context) * 0.03,),
                            Center(
                              child: Image.asset('assets/UTHM2.png'),
                            ),
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
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                     const Text(
                                    "Step 2 : Register your account. ",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                    const  Text(
                                    "Step 3 : Please make a Secret Recovery Phrase (Your Secret Recovery Phrase is very important, Please remember or write it somewhere. You need to fill the phrase if you want to login the Metamask account).",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                      ),
                                      ),
                                       SizedBox(height: deviceHeight(context) * 0.04,),
                                     Text(
                                    "NOTE! Please make sure you have enough SepoliaETH Token to make transaction! Otherwise, you cannot make a transaction with seller. (i.e make sure earn more than 0 SepoliaETH)",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: Constants().secondaryColor
                                       ),
                                      ),
                                          SizedBox(width: deviceWidth(context) * 0.02,),
                                      GestureDetector(
                                          onTap: () {
                                            launch('https://sepoliafaucet.com/');
                                          },
                                          child: Text(
                                            '" https://sepoliafaucet.com/ "',
                                            style: TextStyle(
                                               fontSize: 22,
                                              color: Constants().primaryColor,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        Text(
                                        "Copy your Metamask Account Address and pass it to get free 0.5 SepoliaETH",
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
                                     SelectableText.rich(
                                        TextSpan(
                                          text: "Step 1: Copy the token address from popup dialog. e.g, ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "0xac60Ae1E7BeE92cf1b8BBd35D73EDa77eae1b413",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    const  Text(
                                    "Step 2 : Open Metamask App and login with your password.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                    const  Text(
                                    "Step 3 : Change Ethereum Main Network to Sepolia Test Network.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                 SelectableText.rich(
                                  TextSpan(
                                    text: "Step 4: Add this to Custom Network:\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Network Name - ",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: "Sepolia test network\n",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      TextSpan(
                                        text: "New RPC URL - ",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: "https://sepolia.infura.io/v3/a16a56f42e774895b94db13a6342829e\n",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Chain ID - ",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: "11155111\n",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                       ),
                                      TextSpan(
                                        text: "Currency Symbol - ",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: "SepoliaETH\n",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      TextSpan(
                                        text: "Block explorer URL - ",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: "https://sepolia.etherscan.io/",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                    const  Text(
                                    "Step 5 : Click “Import Tokens”.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                    const  Text(
                                    "Step 6 : Paste the copied token address in Token Address textbox (It will automatically fill in the Token Symbol and Token Decimal).",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                   ),
                                      ),
                                        const  Text(
                                    "Step 7 : Press “IMPORT” button and you ready to go.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w400,
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
                
            
          
      ),
      
    );
  }
}