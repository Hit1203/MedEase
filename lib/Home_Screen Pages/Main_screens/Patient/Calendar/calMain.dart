import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(CalPatient());
}

class CalPatient extends StatefulWidget {
  const CalPatient({super.key});

  @override
  State<CalPatient> createState() => _CalPatientState();
}

class _CalPatientState extends State<CalPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class Appointment {
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final String description; // Add a description field.

  Appointment({
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.description, // Initialize the description field.
  });
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[
    Appointment(
      subject: 'Meeting 1',
      startTime: DateTime.now().add(Duration(hours: 1)),
      endTime: DateTime.now().add(Duration(hours: 2)),
      color: Colors.blue,
      description: 'Discussion on project A',
    ),
    Appointment(
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
