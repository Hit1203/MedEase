import 'package:flutter/material.dart';
import '../../../Color_File/colors.dart';
import '../../Custom_Drawer/patient_drawerfile.dart';

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