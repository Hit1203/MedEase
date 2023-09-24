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
        backgroundColor: Colors.black,
        title: Text("Upcoming Appointments"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: AppointmentRequests.isThereAppointment(curUser.userID!),
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Container(child: Text("Error"),);
                    }
                    else if (snapshot.hasData){
                      //todo
                      // print("is Appo res: ${snapshot.data}  ${curUser.auth_token}");
                      final res = snapshot.data["responseData"]["appointments"];
                      // print("res: ${res[0].runtimeType}" );
                      List<Widget> wl = [];
                      List<dynamic> ml = res.map((e) {
                        var ac = appointmentCard(context, MyAppointment.fromJSON(e),
                            callback);
                        wl.add(ac);
                        return ac;
                      }).toList();
                      print("ml:${ml.runtimeType}");

                      if(res.length == 0){
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Text("No Upcoming Appointments", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),);
                      }
                      else{
                        return Column(
                          children: wl,
                        );
                      }

                    }
                  }

                  return Center(child: CircularProgressIndicator(),);
                }
            ),

          ],
        ),
      ),
    );
  }
}
