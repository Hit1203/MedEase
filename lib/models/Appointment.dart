import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tic_tech_teo_2023/utils/constants.dart';

class Appointment {
    String? doctorId;
    String? patientId;
    String? date;
    String? slot;
    String? id;

    Appointment({
      this.doctorId,
      this.patientId,
      this.slot,
      this.date,
      this.id
    });

    Map<String, String?> toJson() => {
      "doctor_id": doctorId,
      "patient_id": patientId,
      "datetime": reFormatDate(),
    };

    String reFormatDate(){
      print("Appointment: date: $date");
      String strDate = "$date $slot";
      return strDate;
    }
}


class AppointmentRequests{

  static Future create(Appointment appointment) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/appointments/create/'),
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
      Uri.parse('$BASIC_URL/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'id': id}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to cancel appointment");

  }

  static Future isThereAppointment(String token) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'token': token}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to check for appointment");

  }

  static Future getVacantSlots(String token) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/api/get-vacant-slots/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'token': token}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to check for appointment");

  }

}