import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/api_services/api_students.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/view/authentication/login.dart';
import 'package:wemeet_dapps/widget/widgets.dart';
import 'package:email_otp/email_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmNewPassword = TextEditingController();
  final TextEditingController _controllerVerifyOtp = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final EmailOTP myauth = EmailOTP();


  bool isHiddenPassword1 = true;
  bool isHiddenPassword2 = true;
  
  void _togglePasswordView1() {
     setState(() {
       isHiddenPassword1 = !isHiddenPassword1;
     });
  }

    void _togglePasswordView2() {
     setState(() {
       isHiddenPassword2 = !isHiddenPassword2;
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: 'Poppins',
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Password ",
                      style: const TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 40,
                         fontFamily: 'Poppins',
                      ),
                    
                      children: [
                        TextSpan(
                          text: "?",
                          style:  TextStyle(
                             color: Constants().secondaryColor,
                             fontWeight: FontWeight.bold,
                             fontSize: 40,
                             fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),   
                Device.screenType == ScreenType.tablet ?
                 Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/UTHM.png"),
                      ],
                    ),
                  ):     Padding(
                    padding:  EdgeInsets.symmetric(vertical: 4.0.h, horizontal:9.0.h),
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
                       suffixIcon: TextButton(
                        onPressed: () async {
                       
                          // to send a OTP to user email
                          myauth.setConfig(
                              appEmail: "wemeetdeveloper@gmail.com",
                              appName: "WEMEET DAPPS: A REWARD-BASED STUDENT LECTURER APPOINTMENT USING BLOCKCHAIN AND SMART CONTRACTS",
                              userEmail: _controllerEmail.text,
                              otpLength: 6,
                              otpType: OTPType.digitsOnly
                          );
                          if(await myauth.sendOTP() == true) {
                              showMessage(context, "OTP Send Successfully", "OTP Email Verification has been sent to the ${_controllerEmail.text.toString().trim()}", "OK");
                          }else {
                              showMessage(context, "Ooops!", "OTP Email Verification cannot be sent", "OK");
                     
                           }
                        
                        },
                       child: Text(
                        "Send OTP",
                         style: TextStyle(
                            color: Constants().primaryColor,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600
                           ),
                          ) 
                        ),
                    ),  
                     validator: (value) {
                      if(value!.isEmpty) {
                        return "Email cannot be empty";
                      } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                   
                        return "Enter correct email";
                      }else {
                        return null;
                      }
                    },
                    controller: _controllerEmail,
                  ),
                   const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: isHiddenPassword1,
                    decoration: textInputDecoration.copyWith(
                      hintText: "New Password",
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Constants().secondaryColor,
                      ),
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView1,
                          child: isHiddenPassword1 == true ? const Icon(
                            Icons.visibility, 
                            color: Colors.black,
                          ) : const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                      )
                    ),
                     validator: (value) {
                       if(value!.isEmpty) {
                        return "New password cannot be empty";
                       }else if(value.isEmpty || value.length < 8 ){
                        return "New password must be at least 8 characters";
                       }
                       return null;
                    },
                       controller: _controllerNewPassword,
                  ),
                   const SizedBox(height: 20,),
                  TextFormField(
                      obscureText: isHiddenPassword2,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Confirm New Password",
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Constants().secondaryColor,
                        ),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView2,
                          child: isHiddenPassword2 == true ? const Icon(
                            Icons.visibility, 
                            color: Colors.black,
                          ) : const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                      )
                      ),
                      controller: _controllerConfirmNewPassword,
                      validator: (value) {
                       if(value!.isEmpty) {
                        return "Confirm new password cannot be empty";
                       }else if(value.isEmpty || value.length < 8 ){
                        return "Confirm new password must be at least 8 characters";
                       } else if(_controllerNewPassword.text != _controllerConfirmNewPassword.text) {
                          return "Password do not match";
                       } 
                          return null;
                       
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "Verify OTP",
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.verified_user_sharp,
                          color: Constants().secondaryColor,
                        ),
                      ),
                      controller: _controllerVerifyOtp,
                    validator: (value) {
                       if(value!.isEmpty) {
                        return "OTP cannot be empty";
                       }else if(value.isEmpty || value.length < 6 ){
                        return "OTP must be at least 6 characters";
                       }
                       return null;
                    },
                  ),
                  const SizedBox(height: 35,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Constants().secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async{
                        if(_globalKey.currentState!.validate()) {
                           if(await myauth.verifyOTP(otp: _controllerVerifyOtp.text) == true) {
                              resetPassword(_controllerEmail.text.toString().trim(), _controllerConfirmNewPassword.text.toString().trim()); 
                           }else {
                            showMessage(context, "OTP are not Verified", "WronG OTP entered, Please enter correct OTP", "OK");
                           }
                       }
                      }, 
                      child: const Text(
                         "Reset Password",
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

  //function for reset the password
  resetPassword(String email, String password) async{
      var responseStudent = await new Student().studentResetPassword(email.trim(), password.trim());
      var  responseLecturer = await new Lecturer().lecturerResetPassword(email.trim(), password.trim());

      if(responseStudent["success"]) {
        showMessageResetPassword(context, "OTP Verified", "Password for ${email} has been updated", "OK");
      } else if(responseLecturer["success"]) {
        showMessageResetPassword(context, "OTP Verified", "Password for ${email} has been updated", "OK");
      }else {
       showMessage(context, "Ooops!", "Cannot update password for ${email} ", "OK");
      }
  }


  //show message box function
  static void showMessage(BuildContext context, String title, String message, String buttonText) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
           content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
           actions: [ 
              ElevatedButton(
                onPressed: () {
                  nextScreenPop(context);
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
  }

   //show message box reset password function
  static void showMessageResetPassword(BuildContext context, String title, String message, String buttonText) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 24),),
           content: Text(message, style: TextStyle( fontFamily: 'Poppins', fontSize: 16),),
           actions: [ 
              ElevatedButton(
                onPressed: () {
                 nextScreenRemoveUntil(context, Login());
              }, 
              child: Text(buttonText),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Constants().primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Poppins', fontSize: 14))),
              )
           ],
        );
      }
    );
  }
}