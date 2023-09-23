import 'package:flutter/material.dart' ;
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Doctor/Home_Page_Main_Screen.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/PatientHomeScreen.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';
import 'LoginRegister/Login_Register_Main_File.dart';


void main()
async {
  DateTime today = DateTime.now();

  Appointment appointment = Appointment(doctorId: "RQXWZCNIMXXWMVOMWXTT",
      patientId: "WRBNUJOZYQHCVWCYXSRK",
      date: "${today.day}/${today.month}/${today.year}",
      slot: "14:00"
  );

  final Map<String, dynamic> res = await AppointmentRequests.create(appointment);
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
      home: LoginSignupScreen(),
      // home: PatientHomeScreen(),
    );
  }
}
