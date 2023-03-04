import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Lecturer {
  
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
     final response = await http.post(Uri.parse('${Utils.baseURL}/lecturer/resetpassword'),
      headers:  {
        "Accept": "Application/json"
      },
      body: {
        'lecturerEmail': lecturerEmail,
        'lecturerPassword': lecturerPassword
      }
     );

     return jsonDecode(response.body);
  }
}
