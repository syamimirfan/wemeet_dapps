import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Chat {
   //API for contact lecturer button
   Future getContactLecturer(String staffNo) async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/contactlecturer/${staffNo}'), 
       headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for contact student button
   Future getContactStudent(String matricNo) async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/contactstudent/${matricNo}'), 
       headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for student sending message
   Future studentMessage(String matricNo, String stafNo, String messageText) async {
      final response = await http.post(Uri.parse('${Utils.baseURL}/chat/studentmessage'), 
        headers: {
          'Accept': 'Application/json'
        },
        body: {
          'matricNo': matricNo,
          'staffNo': stafNo,
          'messageText': messageText
        }
      );
      return jsonDecode(response.body);
   }

  //API for lecturer sending message
   Future lecturerMessage(String matricNo, String stafNo, String messageText) async {
      final response = await http.post(Uri.parse('${Utils.baseURL}/chat/lecturermessage'), 
        headers: {
          'Accept': 'Application/json'
        },
        body: {
          'matricNo': matricNo,
          'staffNo': stafNo,
          'messageText': messageText
        }
      );
      return jsonDecode(response.body);
   }

   //API for get message
   Future getUserMessage(String matricNo, String staffNo) async {
    final response = await http.get(Uri.parse('${Utils.baseURL}/chat/getmessage/${matricNo}/${staffNo}'),
      headers: {
        "Accept": "Application/json"
      }
    );
    if(response.statusCode == 200) {
       return jsonDecode(response.body);
    }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
    }
   }

   //API for delete message
   Future deleteMessage(int chatId) async {
      final response = await http.delete(Uri.parse('${Utils.baseURL}/chat/deletechat/${chatId}'),
        headers: {
          "Accept" : "Application/json"
        }
      );
       if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception(response.statusCode);
     }
   }

   //API for chat in student
   Future getChatStudents() async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/chatstudent'),
     headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for chat in student
   Future getChatLecturers() async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/chatlecturer'),
     headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }
}