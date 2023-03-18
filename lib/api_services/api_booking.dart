import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Booking {

  /* IN LECTURER SLOT SECTION */
  // API for add slot
  Future addSlot(String staffNo, String day, String slot1, String slot2, String slot3, String slot4, String slot5) async{
    final response = await http.post(Uri.parse('${Utils.baseURL}/slot/addslot/${staffNo}'), 
      headers: {
        'Accept': 'Application/json'
      },
      body: {
        'staffNo': staffNo,
        'day': day,
        'slot1': slot1,
        'slot2': slot2,
        'slot3': slot3,
        'slot4': slot4,
        'slot5': slot5
      }
    );
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  //API for get detail slot
  Future getSlotDetail(String staffNo) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/slot/getslot/${staffNo}'),
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

   //API for update slot
   Future updateSlot(String staffNo, String day, String slot1, String slot2, String slot3, String slot4, String slot5) async {
     final response = await http.patch(Uri.parse('${Utils.baseURL}/slot/editslot/${staffNo}'),
        headers:  {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
        body: {
        'staffNo': staffNo,
        'day': day,
        'slot1': slot1,
        'slot2': slot2,
        'slot3': slot3,
        'slot4': slot4,
        'slot5': slot5
      }
     );
      if(response.statusCode == 200) {
      return jsonDecode(response.body);
     } else {
      print(response.body); 
    throw Exception(response.statusCode);
     }
   }

  /* IN STUDENT&LECTURER BOOKING SECTION */
  //API get booking slot in detail
    Future getBookingSlot(String staffNo,String day) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/booking/slot/${staffNo}/${day}'),
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
   
   //API create booking
   Future addBooking(String matricNo, String staffNo, int numberOfStudents, String date, String time) async {
     final response = await http.post(Uri.parse('${Utils.baseURL}/booking/addbook'),
      headers: {
        'Accept': 'Application/json'
      },
      body: {
        'matricNo': matricNo,
        'staffNo' : staffNo,
        'numberOfStudents': numberOfStudents.toString(),
        'date' : date,
        'time': time,
      }
     );
      return jsonDecode(response.body);
   }

  //API get selected slot from booking 
   Future getBookedSlot(String staffNo,String date) async{ 
      final response = await http.get(Uri.parse('${Utils.baseURL}/booking/booked/${staffNo}/${date}'),
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

   //API to get appointment request
   Future getAppointmentRequest(String staffNo) async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/booking/appointmentrequest/${staffNo}'),
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
   
  //API get all manage booking appointment 
  Future manageAppointmentStudent(String matricNo) async {
    final response = await http.get(Uri.parse('${Utils.baseURL}/booking/studentbooking/${matricNo}'),
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

  //API to reject the appointment requests
  Future rejectAppointmentRequests(int bookingId) async {
    final response = await http.patch(Uri.parse('${Utils.baseURL}/booking/reject/${bookingId}'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
    );
     if(response.statusCode == 200) {
      return jsonDecode(response.body);
     } else {
     throw Exception(response.statusCode);
     }
  }

    //API to accept the appointment requests
  Future acceptAppointmentRequests(int bookingId) async {
    final response = await http.patch(Uri.parse('${Utils.baseURL}/booking/accept/${bookingId}'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
    );
     if(response.statusCode == 200) {
      return jsonDecode(response.body);
     } else {
     throw Exception(response.statusCode);
     }
  }

  
   //API to get appointment accepted in manage appointment and attendance for lecturer
   Future getAcceptedAppointment(String staffNo) async {
     final response = await http.get(Uri.parse('${Utils.baseURL}/booking/lecturerbooking/${staffNo}'),
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

   //API to update appointment in manage appointment for student
   Future updateAppointment(int bookingId, String staffNo, int numberOfStudents, String date, String time) async {
    final response = await http.patch(Uri.parse('${Utils.baseURL}/booking/updatebooking/${bookingId}'),
      headers:  {
        "Accept": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      },
      body: {
        'staffNo': staffNo,
        'numberOfStudents' : numberOfStudents.toString(),
        'date' : date,
        'time' : time 
      } 
    );

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        throw Exception(response.statusCode);
      }
   }

   //API to delete appointment in manage appointment for student and lecturer
   Future deleteAppointment(int bookingId) async {
     final response = await http.delete(Uri.parse('${Utils.baseURL}/booking/deletebooking/${bookingId}'),
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
}