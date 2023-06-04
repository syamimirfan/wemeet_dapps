import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Student {

//API for student login
Future studentLogin(String studEmail, String studPassword) async {
 EasyLoading.show(
     status: "Loading...",
     maskType: EasyLoadingMaskType.black,
  );
  final response = await http.post(Uri.parse('${Utils.baseURL}/student/studentlogin'),
    headers:  {
      "Accept": "Application/json"
    },
    body: {
      'studEmail': studEmail,
      'studPassword': studPassword
    }
  );
   
   if(response.statusCode == 200){
       EasyLoading.dismiss();
       return jsonDecode(response.body);
    } else {
      EasyLoading.showError("ERROR!");
      print(response.body); 
      throw Exception(response.statusCode);
     }
  }

  //API for student reset the password
  Future studentResetPassword(String studEmail, String studPassword) async {
        EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
     final response = await http.patch(Uri.parse('${Utils.baseURL}/student/resetpassword'),
      headers:  {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
     body: {
      'studEmail': studEmail,
      'studPassword': studPassword,
       },
      );
     if(response.statusCode == 200) {
      EasyLoading.dismiss();
      return jsonDecode(response.body);
     } else {
      EasyLoading.showError("ERROR!");
      print(response.body); 
      throw Exception(response.statusCode);
     }
  }

  //API for student detail by passing the matricNo
  Future getStudentDetail(String matricNo) async{ 
      EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
      final response = await http.get(Uri.parse('${Utils.baseURL}/student/getstudent/${matricNo}'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if(response.statusCode == 200) {
        EasyLoading.dismiss();
        return jsonDecode(response.body);
      } else{ 
        EasyLoading.showError("ERROR!");
        throw Exception("Failed to load data");
      }
  }

  //API for lecturer detail in homepage
  Future getLecturer() async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
     final response = await http.get(Uri.parse('${Utils.baseURL}/student/lecturer'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if(response.statusCode == 200) {
        EasyLoading.dismiss();
        return jsonDecode(response.body);
      } else{ 
        EasyLoading.showError("ERROR!");
        throw Exception("Failed to load data");
      }
  }
 
 //API for lecturer information in see more homepage
 Future getLecturerInformationDetail(String staffNo) async {
        EasyLoading.show(
          status: "Loading...",
          maskType: EasyLoadingMaskType.black,
        );
        final response = await http.get(Uri.parse('${Utils.baseURL}/student/lecturerinformation/${staffNo}'),
          headers: {
            "Accept" : "Application/json"
          }
        );
        if(response.statusCode == 200) {
          EasyLoading.dismiss();
          return jsonDecode(response.body);
        }else {
          EasyLoading.showError("ERROR!");
          throw Exception("Failed to load data");
        }
    }
  
  //API update token address for student when first time login
  Future updateTokenAddress(String matricNo, String tokenAddress) async {
     EasyLoading.show(
          status: "Loading...",
          maskType: EasyLoadingMaskType.black,
      );
    final response = await http.patch(Uri.parse('${Utils.baseURL}/student/updatetoken/${matricNo}'),
      headers: {
         "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
      body: {
        'tokenAddress' : tokenAddress
      }
    );
    if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
    }else{
       EasyLoading.showError("ERROR!");
       throw Exception(response.statusCode);
    }
  }

  //API to update firebase token
   Future updateFirebaseToken(String matricNo, String firebaseToken) async {
     EasyLoading.show(
          status: "Loading...",
          maskType: EasyLoadingMaskType.black,
      );
    final response = await http.patch(Uri.parse('${Utils.baseURL}/student/updatefirebasetoken/${matricNo}'),
      headers: {
         "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
      body: {
        'firebaseToken' : firebaseToken
      }
    );
    if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
    }else{
       EasyLoading.showError("ERROR!");
       throw Exception(response.statusCode);
    }
  }
}