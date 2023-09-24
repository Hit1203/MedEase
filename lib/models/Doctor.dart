import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tic_tech_teo_2023/utils/constants.dart';

class Doctor {

  String? id;
  String? name;
  List<String>? nonWorkingDays;
  List<String>? slots;
  Doctor({
    this.id,
    this.name,
    this.nonWorkingDays,
    this.slots
  });

  factory Doctor.fromJSON(Map<String, dynamic> json_) => Doctor(
    id: json_["id"],
    name: json_["name"],
  );

}

class DoctorRequests{
  // static DateTime today = DateTime.now(); //.add(Duration(days: 1));
  // static String strDate = "${today.day}/${today.month}/${today.year}";

  static Future getDoctors(String date) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/api/get-vacant-doctors/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'date': date}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to get doctor list");
  }

}