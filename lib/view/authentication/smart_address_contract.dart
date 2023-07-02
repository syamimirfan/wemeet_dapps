import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_reward.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class SmartContractAddress extends StatefulWidget {
  SmartContractAddress({Key? key, required this.matricNo, required this.statusStudent}): super(key: key);

  final String matricNo;
  final int statusStudent;

  @override
  State<SmartContractAddress> createState() => _SmartContractAddressState(this.matricNo, this.statusStudent);
}

class _SmartContractAddressState extends State<SmartContractAddress> {
  _SmartContractAddressState(this.matricNo, this.statusStudent);
  String matricNo;
  int statusStudent;
  
  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  final TextEditingController _controllerWalletAddress = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isChecked = false;

  String textAgreement = "I have read all the instructions and successfuly import the token. If the token is not imported, I will responsible to not having any reward after the appointment";

  String TOKEN_ADDRESS = "";

   @override
  void initState() {
    super.initState();

    getAddress();
    
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text(
            "Import UTHM Token",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
    
        body: Form(
          key: _globalKey,
          child: Padding(
            padding:  Device.screenType == ScreenType.tablet? 
                      EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.001,) :
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
                        )
                  ),
               
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical:deviceWidth(context) * 0.05),
                    child: Column(
                            children: [
                                const Text(
                                  "1. After you successfully done register your account, you will navigate to this interface: ",           
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                 ),
                            
                              SizedBox(height: 1.h,),
                              Image.asset(
                                "assets/import_token_1.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                               const Text(
                                  "2. This is your Metamask account. The red arrow shows the address of your metamask account. Please do not lost it and keep it for the transaction.",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                 ),
                             
                                SizedBox(height: 1.h,),     
                                Image.asset(
                                "assets/import_token_2.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                              SizedBox(height: 1.h,),
                                const Text(
                                  "3. Please change the Ethereum Main Network to Sepolia Test Network by click the option on the top and click Add Network",                                
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                 ),
                               
                                SizedBox(height: 1.h,), 
                                Image.asset(
                                "assets/import_token_3.png",
                                width: 70.w,
                                scale: 2,               
                              ),
                                 SizedBox(height: 1.5.h,), 
                                 const SelectableText(
                                  "4. At the Custom Networks section, please fill this form : \n Network Name - Sepolia test network \n New RPC URL - https://sepolia.infura.io/v3/a16a56f42e774895b94db13a6342829e \n Chain ID - 11155111 \n Currency Symbol - SepoliaETH \n Block explorer URL - https://sepolia.etherscan.io/",                
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                  ),
                                
                                SizedBox(height: 1.h,),  
                                Image.asset(
                                "assets/import_token_9.png",
                                width: 70.w,
                                scale: 2,               
                              ),
                                SizedBox(height: 1.h,),  
                                const Text(
                                  "5. You can see the test network has successfully changed to Sepolia.",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                    ),
                                
                                Image.asset(
                                "assets/import_token_9.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                               SizedBox(height: 1.h,),  
                                Image.asset(
                                "assets/import_token_4.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                              SizedBox(height: 1.h,),
                              const Text(
                                  "6. IMPORTANT!! you need to import the UTHM token in Goerli Test Network. Do not skip this part.", 
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                 ),
                              
                                SizedBox(height: 1.h,),
                               Image.asset(
                                "assets/import_token_5.png",
                                width: 70.w,
                                scale: 2,               
                              ),
                              SizedBox(height: 1.h,),
                               const Text(
                                  "7. Click Import Token and copy the UTHM Token address below and paste it in Token Address input",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                 ),
                               
                               SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                               Text(
                                 "0xac60...b413",
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                   ),
                               
                                 IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: TOKEN_ADDRESS));
                                    showSnackBarSuccessful(context, "UTHM Token Address copied", Constants().primaryColor);
                                  }, 
                                  icon: Icon(Icons.copy, size: 25, color: Colors.black, )
                                  ),
                                ],
                              ),
                                Image.asset(
                                "assets/import_token_6.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                              SizedBox(height: 1.h,),
                                const Text(
                                  "8. Token Symbol and Token Decimal will auto filled after you successfuly paste the UTHM Token Address",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                         ),
                                
                               SizedBox(height: 1.h,),
                                Image.asset(
                                "assets/import_token_7.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                               SizedBox(height: 1.h,),
                               const Text(
                                  "9. Click Import and you will see the UTHM token at your Metamask account",
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    ),
                                  ),
                                
                                 Image.asset(
                                "assets/import_token_8.png",
                                width: 50.w,
                                scale: 2,
                                height: 50.h,
                              ),
                              SizedBox(height: 3.h,),
                         Text("Your wallet address: ",style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),),       
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "e.g 0xbCC4..7391",
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.token,
                                color: Constants().messageGreyColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Constants().secondaryColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            controller: _controllerWalletAddress,
                            validator: (value) {
                              // Regular expression pattern to match a valid Ethereum address
                              final pattern = r'^0x[a-fA-F0-9]{40}$';
                              final regExp = RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Please enter your wallet address.';
                              }else if (!regExp.hasMatch(value)) {
                                return 'Please enter a valid wallet address.';
                              } else {
                               return null; // Return null if the value is valid
                              }
                            },
                          ),
        
                    
                           SizedBox(height: 1.h,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: isChecked, 
                                    activeColor: Constants().primaryColor,
                                    onChanged: (bool? newChecked) {
                                      setState(() {
                                        isChecked = newChecked!;       
                                      });
                                    }
                                    ),
                                  Flexible(child: Text(textAgreement,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),)),
                                ],
                             ),
                                 SizedBox(height: 5.h,),
                              SizedBox(
                               width: 75.w,
                               child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants().secondaryColor,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),  
                                onPressed: !isChecked ? null : () async{
                                      if(_globalKey.currentState!.validate()) {
                                      showConfirmationImportTokenBox(context, "Confirm?", "Please confirm that you have import UTHM token in Metamask Apps",matricNo, _controllerWalletAddress.text.toString(),statusStudent);
                                    }                               
                                },
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
                  ),
              ),
        ),
          );

  }
   //function to update token address and firebase token when first time login
  updateToken(String? matricNo, String tokenAddress, int statusStudent) async {
     final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();

     var responseStudent = await new Student().updateTokenAddress(matricNo!, tokenAddress);

     if(responseStudent['success']){
        _sharePreferences.setString('matricNo', matricNo);
        _sharePreferences.setInt('statusStudent', statusStudent);
        _sharePreferences.setString('tokenAddress', tokenAddress);
        nextScreenPop(context);
        showSnackBarSuccessful(context, "Login Completed", Constants().acceptedColor);
        Timer(const Duration(seconds: 2), () {
           nextScreenRemoveUntil(context, HomeStudents());
        });
     }else {
        throw Exception(responseStudent['message']);
     }
     
  }

   //message to confirmation of action for import the token
   void showConfirmationImportTokenBox(BuildContext context, String title, String message, String matricNo, String tokenAddress, int statusStudent) {
    showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 20),),
        content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 13),),
        actions: [
         IconButton(
          onPressed: () {
          nextScreenPop(context);
           },
          icon: const Icon(Icons.cancel,color: Colors.red,size: 30,),
           ),
          IconButton(onPressed: () async{
            updateToken(matricNo,tokenAddress, statusStudent);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }

   getAddress() async {
   final responseReward = await new Reward().getReward();
    if(responseReward['success']){
      setState(() {
        TOKEN_ADDRESS = responseReward['address'][0]["TOKEN_ADDRESS"];
      });
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
}