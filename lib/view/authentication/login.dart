// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/support.dart';
import 'package:wemeet_dapps/view/lecturers/home_lecturers.dart';
import 'package:wemeet_dapps/view/authentication/forgot_password.dart';
import 'package:wemeet_dapps/view/students/home_students.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:walletconnect_dart/walletconnect_dart.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // var connector = WalletConnect(
  //     bridge: 'https://bridge.walletconnect.org',
  //     clientMeta: const PeerMeta(
  //         name: 'My App',
  //         description: 'An app for converting pictures to NFT',
  //         url: 'https://walletconnect.org',
  //         icons: [
  //           'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //         ]));

  // var _session, _uri, _signature, session;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isApiCallProcess = false;
  bool studentLogin = false;

 
  //   loginUsingMetamask(BuildContext context) async {
  //   if (!connector.connected) {
  //     try {
  //       session = await connector.createSession(onDisplayUri: (uri) async {
  //         _uri = uri;
  //         await launchUrlString(uri, mode: LaunchMode.externalApplication);
  //       });
  //       print(session.accounts[0]);
  //       setState(() {
  //         _session = session;
  //       });
  //     } catch (exp) {
  //       print(exp);
  //     }
  //   }
  // }
  
  //for reveal the password
  void _togglePasswordView() {
     setState(() {
       isHiddenPassword = !isHiddenPassword;
     });
  }

  @override
  Widget build(BuildContext context) {
    
          return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                  const SizedBox(height: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,  
                      children: [
                      IconButton(
                       onPressed: () {
                       nextScreen(context, Support());
                         }, 
                       icon: const Icon(color: Colors.white,Icons.contact_support_rounded)
                     ),
                      Text.rich(
                      TextSpan(
                     text: "Help",
                     style:  const TextStyle(
                       color: Colors.white,
                       fontSize: 20,
                       fontFamily: 'Poppins',
                     ),
                     recognizer: TapGestureRecognizer()..onTap = () {
                        nextScreen(context, const Support());
                     }
                   ),
                   ),
                      ],
                    )
                  ),
                  const Text(
                  "Login",
                  style: TextStyle(
                     color:Colors.white,
                     fontWeight: FontWeight.bold,
                     fontFamily: 'Poppins',
                     fontSize: 40,
                  ),
                ),
                   const SizedBox(height: 30,),
                   const Text(
                  "Login now to book your appointment! ",
                  style: TextStyle(
                     color:Colors.white,
                     fontWeight: FontWeight.w500,
                     fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                     const SizedBox(height: 20,),
                    Device.screenType == ScreenType.tablet ?
                    Padding(
                  padding:   EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 20.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/UTHM.png"),
                    ],
                  ),
                ) 
                 : 
                  Padding(
                  padding:   EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 10.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/UTHM.png"),
                    ],
                  ),
                ),
                
                 TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: "Email",
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Constants().secondaryColor,
                        ),
                    ),
                    controller: _controllerEmail,
                    validator: (value) {
                      if(value!.isEmpty) {
                            return "Email cannot be empty";
                      } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                        return "Enter correct email";
                      }else {
                        return null;
                      }
                    },
                 ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: isHiddenPassword,
                    validator: (value) {
                       if(value!.isEmpty) {
                        return "Password cannot be empty";
                       }else if(value.isEmpty || value.length < 8 ){
                        return "Password must be at least 8 characters";
                       }
                       return null;
                    },
                    controller: _controllerPassword,
                    decoration: textInputDecoration.copyWith(
                        hintText: "Password",
                        fillColor: Colors.white,
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: isHiddenPassword == true ? const Icon(
                            Icons.visibility, 
                            color: Colors.black,
                          ) : const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Constants().secondaryColor,
                        ),
                    ),
                 ),
                  const SizedBox(height: 20,),
                 Text.rich(
                   TextSpan(
                     text: "Forgot password?",
                     style:  const TextStyle(
                       color: Colors.white,
                       decoration: TextDecoration.underline,
                       fontSize: 18,
                       fontFamily: 'Poppins',
                     ),
                     recognizer: TapGestureRecognizer()..onTap = () {
                        nextScreen(context, ForgotPassword());
                     }
                   ),
                 ),
          
                   const SizedBox(height: 35,),
          
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().secondaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                
                    onPressed: () async{
                      if(_globalKey.currentState!.validate()) {
                       login(_controllerEmail.text.toString(), _controllerPassword.text.toString());
                      }
                
                     // loginUsingMetamask(context);
                     },
                     child:  const Text(
                       "Sign In",
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
      );
     } 

   //function for authorization login student and lecturer
   login(String email, String password) async{
   final SharedPreferences  _sharedPreferences = await SharedPreferences.getInstance();

    var responseStudent = await new Student().studentLogin(email.trim(), password.trim());
    var responseLecturer = await new Lecturer().lecturerLogin(email.trim(), password.trim());

    if(responseStudent['success'] && responseStudent['status'] == 1) {
      //to set the sesssion and keep logged 
      String matricNumber = responseStudent['student'][0]['matricNo'];
      int statusStudent = responseStudent['student'][0]['status'];


      _sharedPreferences.setString('matricNo', matricNumber);
      _sharedPreferences.setInt('statusStudent', statusStudent);
      
      nextScreenRemoveUntil(context, HomeStudents());
      //redirect to metamask application in playstore
      //   await LaunchApp.openApp(
      //    androidPackageName: 'io.metamask&hl=en',
      //    openStore: true,
      // );

    } else if(responseLecturer['success'] && responseLecturer['status'] == 2) {

      //to set the sesssion and keep logged 
      String staffNo = responseLecturer['lecturer'][0]['staffNo'];
      int statusLecturer = responseLecturer['lecturer'][0]['status'];

      _sharedPreferences.setString('staffNo',staffNo);
      _sharedPreferences.setInt('statusLecturer', statusLecturer);
       
      nextScreenRemoveUntil(context, HomeLecturer());
  
    } else {
     showErrorMessage(context, "Invalid User", "Email or Password are not valid", "OK");
    }

  }
  
  static void showErrorMessage(BuildContext context, String title, String message, String buttonText) {
      showDialog(context: context,
       builder: (BuildContext context) {
        return AlertDialog( 
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
          content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
          actions: [
             ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor),textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              child:  Text(buttonText),
              onPressed: () {
                 nextScreenPop(context);
              },
            )
          ],
         );
        }
       );
  }
}