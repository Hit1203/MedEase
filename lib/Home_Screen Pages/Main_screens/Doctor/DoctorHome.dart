import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Hello Dr. ${curUser.name}"),
      ),

      body: Column(
        children: [
            Expanded(

                child: sfCalendarMonth())
        ],
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



      // events.clear();
      //
      // for(var e in res){
      //   final uid = e.get("uid");
      //   final title = e.get("title");
      //   final from = e.get("from");
      //   final to = e.get("to");
      //   final comment = e.get("comment");
      //   final backgroundColor = e.get("backgroundColor");
      //   final isAllDay = e.get("isAllDay");
      //
      //   event = Event(
      //     uid: uid,
      //     title: title,
      //     from: Utils.stringToDateTime(from),
      //     to: Utils.stringToDateTime(to),
      //     comment: comment,
      //     backgroundColor: backgroundColor,
      //     isAllDay: isAllDay,
      //   );
      //   events.add(event);
      // }

      return SfCalendar(
        firstDayOfWeek: 1,
        dataSource: _AppointmentDataSource(patientList),
        view: CalendarView.day,
        onLongPress: (details) {
          // final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
          // eventViewModel.setDate(details.date!);

          // showModalBottomSheet(
          //   context: context,
          //   // builder: (context) => const DailyWidget(),
          // );
        },
      );
    }
    if(!snapshot.hasData) {
        return Center(
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.2),
            child: SpinKitCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        );
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