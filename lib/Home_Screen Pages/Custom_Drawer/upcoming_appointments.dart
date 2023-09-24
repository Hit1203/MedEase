import 'package:flutter/material.dart';

import '../../models/Appointment.dart';
import '../../utils/constants.dart';
import '../Main_screens/Patient/PatientHomeScreen.dart';

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({super.key});

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {

  void callback(){
    print("callback triggerd");

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Appointments"),
      ),

      body: Column(
        children: [
          FutureBuilder(
              future: AppointmentRequests.isThereAppointment(curUser.userID!),
              builder: (context, snapshot){

                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return Container(child: Text(""),);
                  }
                  else if (snapshot.hasData){
                    //todo
                    // print("is Appo res: ${snapshot.data}  ${curUser.auth_token}");
                    final res = snapshot.data["responseData"]["appointments"];
                    if(res.length == 0){
                      return Container();
                    }
                    else{
                      return Column(
                        children: res.map((e) => appointmentCard(context, MyAppointment.fromJSON(e), callback)).toList(),
                      );
                    }

                  }
                }

                return Container();
              }
          ),

        ],
      ),
    );
  }
}
