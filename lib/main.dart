import 'package:flutter/material.dart' ;
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Doctor/Home_Page_Main_Screen.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/calMain.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/PatientHomeScreen.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';
import 'package:tic_tech_teo_2023/models/Doctor.dart';
import 'LoginRegister/Login_Register_Main_File.dart';


void main()
async {
  DateTime today = DateTime.now();
  String strDate = "${today.day}/${today.month}/${today.year}";
  // Appointment appointment = Appointment(doctorId: "RQXWZCNIMXXWMVOMWXTT",
  //     patientId: "WRBNUJOZYQHCVWCYXSRK",
  //     date: strDate,
  //     slot: "14:00"
  // );
  //
  // final Map<String, dynamic> res = await AppointmentRequests.create(appointment);
  final Map<String, dynamic> res = await DoctorRequests.getDoctors(strDate);
  print("========res: $res");

  runApp(Myapp()) ;
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      // home: LoginSignupScreen(),
      // home: CalPatient(),
      home: PatientHomeScreen(),
      // home: HomePage(),
    );
  }
}
