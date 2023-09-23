import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

import '../models/Doctor.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  bool isThereAppointment = false;

  Appointment appointment = Appointment();
  List<Doctor> doctorList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MedEase"),
      ),

      body: Column(
        children: [
          isThereAppointment? appointmentCard(appointment):Container(),
          displayDoctors(doctorList),

        ],
      ),
    );
  }
}


Container appointmentCard(Appointment appointment){

  return Container(
    child: Column(
      children: [
        Text("Up Coming Appointment"),

        Text("Doctor: "),
        Text(appointment.doctorName!),

        Text("Date: "),
        Text(appointment.date!),

        Text("Time"),
        Text(appointment.slot!),
      ],
    ),
  );

}

Container displayDoctors(List<Doctor> doctorList){
  return Container(
    child: ListView.builder(
      itemCount: doctorList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Dr. ${doctorList[index].name}"),
          onTap: () {

          },
        );
      }),
  );
}