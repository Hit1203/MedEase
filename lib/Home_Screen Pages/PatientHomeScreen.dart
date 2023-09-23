import 'package:flutter/material.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  bool isThereAppointment = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MedEase"),
      ),

      body: Column(
        children: [

        ],
      ),
    );
  }
}


Container appointmentCard(){

  return Container(
    child: Column(
      children: [
        Text("Up Coming Appointment"),

        Text("Doctor: ")
        // Text(data)
      ],
    ),
  );

}