import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tic_tech_teo_2023/utils/constants.dart';

class Appointment {
    String? doctorName;
    String? patientToken;
    String? date;
    String? slot;
    String? id;

    Map<String, String?> toJson() => {
      "doctor_name": doctorName,
      "patient_name": patientToken,
      "data": date,
      "slot": slot,
    };
}


class AppointmentRequests{

  static Future book(Appointment appointment) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(appointment.toJson()),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to get appointment");
  }

  static Future cancel(String id) async {
    final res = await http.post(
      Uri.parse('$basicUri/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJSON(user)),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to register");

  }
}