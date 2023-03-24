import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class SmartContractAddress extends StatefulWidget {
  SmartContractAddress({Key? key, required this.matricNo, required this.statusStudent, required this.tokenAddress}): super(key: key);

  String matricNo;
  String tokenAddress;
  int statusStudent;

  @override
  State<SmartContractAddress> createState() => _SmartContractAddressState(this.matricNo, this.statusStudent, this.tokenAddress);
}

class _SmartContractAddressState extends State<SmartContractAddress> {
  _SmartContractAddressState(this.matricNo, this.statusStudent, this.tokenAddress);
  String matricNo;
  String tokenAddress;
  int statusStudent;
  
  double deviceHeight(BuildContext context) =>  MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) =>  MediaQuery.of(context).size.width;

  String UTHMTokenAddress = "0xD540796299d67A0e7f8880131159C2221e99EfF2";
  bool isChecked = false;
  String textAgreement = "I have read all the instructions and successfuly import the token. If the token is not imported, I will responsible to not having any reward after the appointment";

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

      body: Padding(
        padding:  Device.screenType == ScreenType.tablet? 
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
                        textAlign: TextAlign.justify,
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
                        textAlign: TextAlign.justify,
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
                      "3. Please change the Ethereum Main Network to Goerli Test Network by click the option on the top",
                        textAlign: TextAlign.justify,
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
                      SizedBox(height: 1.h,),  
                      const Text(
                      "4. You can see the test network has successfully changed to Goerli.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        ),
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
                      "5. IMPORTANT!! you need to import the UTHM token in Goerli Test Network. Do not skip this part.",
                        textAlign: TextAlign.justify,
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
                      "6. Click Import Token and copy the UTHM Token address below and paste it in Token Address input",
                        textAlign: TextAlign.justify,
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
                     "0xD540...EfF2",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        ),
                       ),
                       IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: UTHMTokenAddress));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("UTHM Token Address has been copied"),
                              duration: Duration(seconds: 3),
                            ),
                          );
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
                      "7. Token Symbol and Token Decimal will auto filled after you successfuly paste the UTHM Token Address",
                        textAlign: TextAlign.justify,
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
                      "8. Click Import and you will see the UTHM token at your Metamask account",
                        textAlign: TextAlign.justify,
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
                        Expanded(child: Text(textAgreement, textAlign: TextAlign.justify,style: TextStyle(fontFamily: 'Poppins', fontSize: 15, ),)), 
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
                         showConfirmationImportTokenBox(context, "Confirm?", "Please confirm that you have import UTHM token in Metamask Apps",matricNo, tokenAddress,statusStudent);
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
    );
  }
   //function to update token address when first time login
  updateTokenAddressMetamask(String? matricNo, String tokenAddress, int statusStudent) async {
     final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
     var responseStudent = await new Student().updateTokenAddress(matricNo!, tokenAddress);
     if(responseStudent['success']){
        _sharePreferences.setString('matricNo', matricNo);
        _sharePreferences.setInt('statusStudent', statusStudent);
        _sharePreferences.setString('tokenAddress', tokenAddress);
        nextScreenRemoveUntil(context, HomeStudents());
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
            updateTokenAddressMetamask(matricNo,tokenAddress, statusStudent);
          }, 
         icon: const Icon(Icons.done, color: Colors.green,size: 30,)),            
      ],
      );
      }
    );
  }

}