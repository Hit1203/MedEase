import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(CalPatient());
}

class CalPatient extends StatefulWidget {
  String? doctorName;
  List<String>? nonWorkingDays;
  List<String>? slots;

  CalPatient({this.doctorName, this.slots, this.nonWorkingDays, super.key});

  @override
  State<CalPatient> createState() => _CalPatientState();
}

class _CalPatientState extends State<CalPatient> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr. Hersh Mori"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 500,
              child: SfCalendar(
                onSelectionChanged: (details){
                  print(details.date) ;
                },
                view: CalendarView.month,
                dataSource: MeetingDataSource(getAppointments()),
                onTap: (CalendarTapDetails details) {
                  // Handle tap on a calendar element here, if needed.
                },
              ),
            ),

            displaySlots(),

          ],
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalAppointment> source) {
    appointments = source;
  }
}

class CalAppointment {
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final String description; // Add a description field.

  CalAppointment({
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.description, // Initialize the description field.
  });
}

List<CalAppointment> getAppointments() {
  List<CalAppointment> meetings = <CalAppointment>[
    CalAppointment(
      subject: 'Meeting 1',
      startTime: DateTime.now().add(Duration(hours: 1)),
      endTime: DateTime.now().add(Duration(hours: 2)),
      color: Colors.blue,
      description: 'Discussion on project A',
    ),
    CalAppointment(
      subject: 'Meeting 2',
      startTime: DateTime.now().add(Duration(hours: 3)),
      endTime: DateTime.now().add(Duration(hours: 4)),
      color: Colors.green,
      description: 'Planning for upcoming events',
    ),
    // Add more appointments as needed
  ];

  return meetings;
}


Container displaySlots(){
  List<String> sarr = ["12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30","12:30-13:00", "13:00-13:30",];

  return Container(
    height: 200,
    width: 350,
    child: GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        // childAspectRatio: 1,
      ),
      // scrollDirection: Axis.horizontal,

      itemCount: sarr.length,
      itemBuilder: (_,int index){
        return Container(
          // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(border: Border.all()),
          child: Text(sarr[index]),
        );
      },
    ),
  );

}