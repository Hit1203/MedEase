import 'dart:js';

import 'package:flutter/material.dart';
import '../../../Color_File/colors.dart';
import '../../Custom_Drawer/patient_drawerfile.dart';
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
        backgroundColor: Colors.transparent, // Make the AppBar background transparent
        elevation: 0, // Remove the shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HomeScreen.Appbar_color1,
                Colors.grey
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('MedEase'),
      ),
      drawer:Drawer(
        child: drawerPatient(),
      ) ,

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