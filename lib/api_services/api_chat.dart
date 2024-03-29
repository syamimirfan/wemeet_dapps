import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Chat {
  
   //API for contact lecturer button
   Future getContactLecturer(String staffNo) async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      ); 
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/contactlecturer/${staffNo}'), 
       headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{
       EasyLoading.showError("ERROR!");
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for contact student button
   Future getContactStudent(String matricNo) async {
      EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      ); 
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/contactstudent/${matricNo}'), 
       headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{
      EasyLoading.showError("ERROR!");
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for student sending message
   Future studentMessage(String matricNo, String stafNo, String messageText,String sendTextTime) async {
      final encodedMessageText = Uri.encodeComponent(messageText);
      final response = await http.post(Uri.parse('${Utils.baseURL}/chat/studentmessage'), 
        headers: {
          'Accept': 'Application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'matricNo': matricNo,
          'staffNo': stafNo,
          'messageText': encodedMessageText,
          'sendTextTime': sendTextTime,

        }
      );
     if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

  //API for lecturer sending message
   Future lecturerMessage(String matricNo, String stafNo, String messageText, String sendTextTime) async {
     final encodedMessageText = Uri.encodeComponent(messageText);
      final response = await http.post(Uri.parse('${Utils.baseURL}/chat/lecturermessage'), 
        headers: {
          'Accept': 'Application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'matricNo': matricNo,
          'staffNo': stafNo,
          'messageText': encodedMessageText,
          'sendTextTime': sendTextTime,
        }
      );
        if(response.statusCode == 200) {
       return jsonDecode(response.body);
     }else{
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
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

   //API for delete message in student
   Future deleteMessage(String messageText) async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      ); 
      final response = await http.delete(Uri.parse('${Utils.baseURL}/chat/deletechat/${messageText}'),
        headers: {
          "Accept" : "Application/json"
        }
      );
        if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{
      EasyLoading.showError("ERROR!");
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for chat in student
   Future getChatStudents() async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      ); 
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/chatstudent'),
     headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{
       EasyLoading.showError("ERROR!");
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }

   //API for chat in student
   Future getChatLecturers() async {
      EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      ); 
     final response = await http.get(Uri.parse('${Utils.baseURL}/chat/chatlecturer'),
     headers: {
        "Accept" : "Application/json"
       }
     );

     if(response.statusCode == 200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{
       EasyLoading.showError("ERROR!");
       throw Exception('API request failed with status code: ${response.statusCode}');
     }
   }
}