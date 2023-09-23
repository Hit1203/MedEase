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
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make the AppBar background transparent
          elevation: 0, // Remove the shadow
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
          title: const Text('MedEase'),
        ),
        drawer: const Drawer(
           child : drawer(),
            ),


        body: Column(
          children: [

            SingleChildScrollView(
              child: FutureBuilder(
                  future: AppointmentRequests.getAppointmentList(curUser.userID!),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return const Text("error");
                    }

                    else if(snapshot.hasData){
                      print("doc home screen: ${snapshot.data}");
                      List<dynamic> res = snapshot.data["responseData"]["appointments"];
                      print("doc home screen type: ${res[0].runtimeType}");
                      List<MyAppointment> userList = res.map((e) => MyAppointment.fromJSON(e)).toList();

                      Map<DateTime, List<MyAppointment>> groupedUser = groupBy<MyAppointment, DateTime>(
                          userList,
                              (appointment) => DateTime(
                                appointment.dt!.year,
                                appointment.dt!.month,
                                appointment.dt!.day,
                          ));

                      return Container(
                        height: MediaQuery.of(context).size.height-100,
                        child: ListView.builder(
                            itemCount: groupedUser.length,
                            itemBuilder: (context, index) {
                              DateTime date = groupedUser.keys.elementAt(index);
                              List<MyAppointment> userForDate = groupedUser[date]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      formatDate(date),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ...userForDate.map((appo) {
                                    return Dismissible(
                                      direction: DismissDirection.horizontal,
                                      confirmDismiss: (direction) async {
                                        if (direction == DismissDirection.startToEnd) {
                                          final res = await AppointmentRequests.cancel(appo.id!);
                                          print("doc res: $res");
                                          if(res["deleted"] == true) userList.remove(index);
                                        }
                                        setState(() {
                                        });


                                      },
                                      key: UniqueKey(),
                                      background: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 300),
                                          child: Icon(Icons.delete),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          print("hello") ;
                                        },
                                        child: Card(
                                          child: ListTile(
                                            title: Text(appo.patientName!),
                                            subtitle: SingleChildScrollView(
                                              child: Text(appo.slot!),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              );
                            }),
                      );


                    }

                    return const Center(child: CircularProgressIndicator(),);

              }),
            )

          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day) {
    return 'Today';
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day - 1) {
    return 'Yesterday';
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day > now.day - 7) {
    return DateFormat('EEEE').format(date);
  } else if (date.year == now.year) {
    return DateFormat('dd/MM').format(date);
  } else {
    return DateFormat.yMMMEd().format(date);
  }
}

// Container displayPatient(context, Map<DateTime, List<MyAppointment>> userList){
//   return
// }