import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

import 'package:collection/collection.dart';
import '../../../models/User.dart';
import '../../Custom_Drawer/doctor_drawerFile.dart';
import '../../Profile/Patient/Patient_profile.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    int activeIndex  = -1 ;

    void setActiveIndex(int index) {
      setState(() {
        activeIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: drawer(),
        ),
    appBar: AppBar(
      backgroundColor: Colors.black,
    title: Text("Hello Dr. ${curUser.name}"),
    ),

    body: Column(
    children: [
    Expanded(
      child: Container(
          
          child: Center(child: sfCalendarMonth())),
    )
    ],
    ),
    ),
    );
  }
}


Appointment fromJSON(Map<String, dynamic> json_){
  String title = json_["patient_name"];
  List<String> strDate  = json_["date_time"].toString().split(" ")[0].split("/");
  String strTime  = json_["date_time"].toString().split(" ")[1]; //.split(":").map((e) => int.parse(e)).toList();
  DateTime sTime  = DateTime.parse("${strDate[2]}-${strDate[1]}-${strDate[0]} $strTime");
  DateTime eTime = sTime.add(Duration(minutes: 30));
  return Appointment(startTime: sTime, endTime: eTime, subject: title);
}

Widget sfCalendarMonth() => FutureBuilder(
  // future: AppointmentRequests.getAppointmentList(curUser.userID!),
  future: AppointmentRequests.getAppointmentList("JATUIOKYCEPKCKDORQTW"),
  builder: (context, snapshot) {
    if(snapshot.hasData) {
      List<dynamic> res = snapshot.data['responseData']['appointments'];

      print("doc home res: $res");

      List<Appointment> patientList = res.map((e) => fromJSON(e)).toList();

      return SfCalendar(
        appointmentTextStyle: TextStyle(color: Colors.white), // Set text color for appointments
        todayTextStyle: TextStyle(color: Colors.white),
        todayHighlightColor : Colors.blueAccent,
        firstDayOfWeek: 1,
        dataSource: _AppointmentDataSource(patientList),
        view: CalendarView.day,
        onLongPress: (details) {
        },
      );
    }
    if(!snapshot.hasData) {
      return const CircularProgressIndicator();
    }
    if(snapshot.hasError) {
      return Text(snapshot.hasError.toString());
    }
    return Container();
  },
);



class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }
}