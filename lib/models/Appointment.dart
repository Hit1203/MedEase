import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tic_tech_teo_2023/utils/constants.dart';

class MyAppointment {
    String? doctorId;
    String? doctorName;
    String? patientId;
    String? patientName;
    String? date;
    String? slot;
    String? id;

    DateTime? dt;

    MyAppointment({
      this.doctorId,
      this.doctorName,
      this.patientId,
      this.patientName,
      this.slot,
      this.date,
      this.id,
      this.dt
    });

    Map<String, String?> toJson() => {
      "doctor_id": doctorId,
      "patient_id": patientId,
      "datetime": reFormatDate(),
    };

    factory MyAppointment.fromJSON(Map<String, dynamic> json_) => MyAppointment(
      id: json_["custom_id"],
      doctorId: json_["doctor"],
      doctorName: json_["d_name"],
      date: json_["date_time"].toString().split(" ")[0],
      slot: json_["date_time"].toString().split(" ")[1],
      patientId: json_["patient"],
      patientName: json_["patient_name"],
      dt: DateTime.parse("${json_["date_time"].toString().split(" ")[0].split("/")[2]}-${json_["date_time"].toString().split(" ")[0].split("/")[1]}-${json_["date_time"].toString().split(" ")[0].split("/")[0]} ${json_["date_time"].toString().split(" ")[1]}"),
    );

    String reFormatDate(){
      print("Appointment: date: $date");
      String strDate = "$date $slot";
      return strDate;
    }
}


class AppointmentRequests{

  static Future create(MyAppointment appointment) async {
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
      Uri.parse('$BASIC_URL/appointments/delete/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'appointment_id': id, 'patient': !curUser.isDoctor!?curUser.userID:"", 'doctor': curUser.isDoctor!?curUser.userID:""}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to cancel appointment");

  }

  static Future isThereAppointment(String token) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/api/get-user-appointments/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'patient': token}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to check for appointment");

  }

  static Future getAppointmentList(String token) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/api/get-doctor-appointments/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'custom_id': token}),
    );

    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to check for appointment");

  }



  static Future getVacantSlots(String token, String date) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/api/get-vacant-slots/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'doctor': token, 'date': date}),
    );
    if (res.statusCode == 200)
      return jsonDecode(res.body);
    else
      throw Exception("Failed to check for appointment");

  }

}