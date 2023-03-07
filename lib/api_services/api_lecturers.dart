import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Lecturer {
  
  //API for lecturer login
  Future lecturerLogin(String lecturerEmail, String lecturerPassword) async{
    final response = await http.post(Uri.parse('${Utils.baseURL}/lecturer/lecturerlogin'),
      headers: {
      'Accept': 'Application/json'
      },
      body: {
      'lecturerEmail': lecturerEmail,
      'lecturerPassword': lecturerPassword
      }
    );
    return jsonDecode(response.body);
  }

  //API for lecturer reset the password
    Future lecturerResetPassword(String lecturerEmail, String lecturerPassword) async {
     final response = await http.patch(Uri.parse('${Utils.baseURL}/lecturer/resetpassword'),
      headers:  {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
     body: {
      'lecturerEmail': lecturerEmail,
      'lecturerPassword': lecturerPassword,
       },
       );
     if(response.statusCode == 200) {
      return jsonDecode(response.body);
     } else {
      print(response.body); 
    throw Exception(response.statusCode);
     }
  }
  
  //API for lecturer detail by passing the staffNo
  Future getLecturerDetail(String staffNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/lecturer/getlecturer/${staffNo}'),
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


}
