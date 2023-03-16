import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Student {

//API for student login
Future studentLogin(String studEmail, String studPassword) async {
  final response = await http.post(Uri.parse('${Utils.baseURL}/student/studentlogin'),
    headers:  {
      "Accept": "Application/json"
    },
    body: {
      'studEmail': studEmail,
      'studPassword': studPassword
    }
  );
   
   return jsonDecode(response.body);
  }

  //API for student reset the password
  Future studentResetPassword(String studEmail, String studPassword) async {
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
      return jsonDecode(response.body);
     } else {
      print(response.body); 
    throw Exception(response.statusCode);
     }
  }

  //API for student detail by passing the matricNo
  Future getStudentDetail(String matricNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/student/getstudent/${matricNo}'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if(response.statusCode == 200) {
          return jsonDecode(response.body);
      } else{ 
         throw Exception("Failed to load data");
      }
  }

  //API for lecturer detail in homepage
  Future getLecturer() async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/student/lecturer'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if(response.statusCode == 200) {
          return jsonDecode(response.body);
      } else{ 
         throw Exception("Failed to load data");
      }
  }
 
 //API for lecturer information in see more homepage
 Future getLecturerInformationDetail(String staffNo) async {
        final response = await http.get(Uri.parse('${Utils.baseURL}/student/lecturerinformation/${staffNo}'),
          headers: {
            "Accept" : "Application/json"
          }
        );
        if(response.statusCode == 200) {
          return jsonDecode(response.body);
        }else {
          throw Exception("Failed to load data");
        }
 }

}