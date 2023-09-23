import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/models/Doctor.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import '../../../Color_File/colors.dart';
import '../../Custom_Drawer/patient_drawerfile.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

import 'calMain.dart';


class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  bool isThereAppointment = false;

  Appointment appointment = Appointment();
  DateTime today = DateTime.now();



  @override
  void initState(){
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    String strDate = "${today.day}/${today.month}/${today.year}";

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
          FutureBuilder(
              future: AppointmentRequests.isThereAppointment(curUser.userID!),
              builder: (context, snapshot){

                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return Container(child: Text("Error"),);
                  }
                  else if (snapshot.hasError){
                    //todo
                    return appointmentCard(appointment);
                  }
                }

                return Container();
              }
          ),
          
          FutureBuilder(
              future: DoctorRequests.getDoctors(strDate),
              builder: (context, snapshot){

                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return Text("Error");
                  }
                  else if (snapshot.hasData){
                    final Map<String, dynamic> res = snapshot.data as Map<String, dynamic>;
                    List<dynamic> strDoctorList = res["responseData"]["vacant_doctors"];
                    print("type:${strDoctorList[0].runtimeType}");
                    print("type:${strDoctorList[0]}");

                    List<Doctor> doctorList = strDoctorList.map((e) => Doctor.fromJSON(e)).toList();
                    return displayDoctors(context, doctorList);
                    return Text("$res");
                  }
                }

                return Center(child: CircularProgressIndicator(),);

              }),

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
        Text(appointment.doctorId!),

        Text("Date: "),
        Text(appointment.date!),

        Text("Time"),
        Text(appointment.slot!),
      ],
    ),
  );

}

Container displayDoctors(context, List<Doctor> doctorList){
  return Container(
    height: MediaQuery.of(context).size.height-100,
    child: ListView.builder(
      itemCount: doctorList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Dr. ${doctorList[index].name}"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CalPatient(doctorName: doctorList[index].name)));
          },
        );
      }),
  );
}