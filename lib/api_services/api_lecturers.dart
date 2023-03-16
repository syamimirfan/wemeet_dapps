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

 //API for get all lecturer list in book1.student.dart
  Future getLecturerList() async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/lecturer/view'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if (response.statusCode == 200) {
         return jsonDecode(response.body);
     
      } else {
        throw Exception('API request failed with status code: ${response.statusCode}');
      }
   }

   //API for update the lecturer information 
Future lecturerInformation(String staffNo, int floorLvl, int roomNo, String academicQualification1,String academicQualification2, String academicQualification3, String academicQualification4) async {
      final response = await http.patch(Uri.parse('${Utils.baseURL}/lecturer/lecturerinformation/${staffNo}'),
        headers: {
          "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
        },
        body: {
          'floorLvl': floorLvl.toString(),
          'roomNo': roomNo.toString(),
          'academicQualification1': academicQualification1,
          'academicQualification2': academicQualification2,
          'academicQualification3': academicQualification3,
          'academicQualification4': academicQualification4
        }
      );

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        print(response.body);
        throw Exception(response.statusCode);
      }
  }

   //API for get lecturer profile
  Future getLecturerProfile(String staffNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/lecturer/lecturerprofile/${staffNo}'),
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
  
  //API for get lecturer detail in book2
    Future getLecturerBook2(String staffNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/lecturer/book2/${staffNo}'),
        headers: {
          "Accept": "Application/json"
        }
      );
      if (response.statusCode == 200) {
         return jsonDecode(response.body);
     
      } else {
        throw Exception('API request failed with status code: ${response.statusCode}');
      }
   }


}
