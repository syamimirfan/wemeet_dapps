import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wemeet_dapps/constants/utils.dart';

class Booking {

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
      print(response.body);
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
}