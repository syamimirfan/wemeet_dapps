import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Attendance{
    
  //API add absent attendance in lecturer
  Future absentAttendance(String matricNo, String staffNo, int numberOfStudents,String date, String time) async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
    final response  = await http.post(Uri.parse('${Utils.baseURL}/attendance/addattendance/absent'),
      headers: {
        "Accept" : "Application/json"
      },
      body: {
        "matricNo": matricNo,
        "staffNo": staffNo,
        "numberOfStudents": numberOfStudents.toString(),
        "date" : date,
        "time": time,
      }
    );
    
    if(response.statusCode == 200) {
      EasyLoading.dismiss();
      return jsonDecode(response.body);
    }else {
      EasyLoading.showError("ERROR!");
      throw Exception(response.statusCode);
    }
  } 

   //API add absent attendance in lecturer
  Future attendAppointment(String matricNo, String staffNo, int numberOfStudents,String date, String time) async {
    EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
    final response  = await http.post(Uri.parse('${Utils.baseURL}/attendance/addattendance/attend'),
      headers: {
        "Accept" : "Application/json"
      },
      body: {
        "matricNo": matricNo,
        "staffNo": staffNo,
        "numberOfStudents": numberOfStudents.toString(),
        "date" : date,
        "time": time,
      }
    );
    
    if(response.statusCode == 200) {
      EasyLoading.dismiss();
      return jsonDecode(response.body);
    }else {
      EasyLoading.showError("ERROR!");
      throw Exception(response.statusCode);
    }
  } 

  //API to get attendance in student
  Future getAttendance(String matricNo) async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
    final response = await http.get(Uri.parse('${Utils.baseURL}/attendance/getattendance/${matricNo}'),
      headers: {
        "Accept": "Application/json",
      }
    );
     if(response.statusCode ==  200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{ 
       EasyLoading.showError("ERROR!");
       throw Exception(response.statusCode);
     }
  }

  //API to delete attendance in student
  Future deleteAttendance(int attendanceId) async {
      EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
      final response = await http.delete(Uri.parse('${Utils.baseURL}/attendance/deleteattendance/${attendanceId}'),
       headers:  {
        "Accept": "Application/json"
       }
     );

     if(response.statusCode == 200) {
       EasyLoading.dismiss();
        return jsonDecode(response.body);
     }else {
       EasyLoading.showError("ERROR!");
        throw Exception(response.statusCode);
     }
  }
  
  
}