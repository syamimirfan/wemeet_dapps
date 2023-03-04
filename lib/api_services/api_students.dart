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
     final response = await http.post(Uri.parse('${Utils.baseURL}/student/resetpassword'),
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

  //API for student detail by passing the matricNo
  Future getStudentDetail(String matricNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/student/getstudent/${matricNo}'));
      if(response.statusCode == 200) {
          return jsonDecode(response.body);
      } else{ 
         throw Exception("Failed to load data");
      }
  }


}