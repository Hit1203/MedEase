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
    id: json_["user_id"],
    name: json_["name"],
    nonWorkingDays: json.decode(json_["non_working_days"]).cast<String>().toList(),
    slots: json.decode(json_["slots"]).cast<String>().toList(),
  );

}

class DoctorRequests{
  static Future getDoctors() async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to get doctor list");
  }

}