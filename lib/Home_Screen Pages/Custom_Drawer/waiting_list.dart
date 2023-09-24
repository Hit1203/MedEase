import 'package:flutter/material.dart';

import '../../models/Appointment.dart';

class WaitingList extends StatefulWidget {
  const WaitingList({super.key});

  @override
  State<WaitingList> createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Waiting List"),
      ),

      body: Column(
        children: [
          FutureBuilder(
              future: AppointmentRequests.getAppointmentList("JATUIOKYCEPKCKDORQTW"),
              builder: (context, snapshot){
                if (snapshot.hasData) {

                }
                List<dynamic> res = snapshot.data['responseData']['appointments'];

                print("doc home res: $res");



              return Center(child: CircularProgressIndicator(),);
              })
        ],
      ),
    );
  }
}
