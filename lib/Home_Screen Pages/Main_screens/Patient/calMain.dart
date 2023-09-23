import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(CalPatient());
}

class CalPatient extends StatefulWidget {
  String? doctorName;

  CalPatient({this.doctorName, super.key});

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
        title: Text("Dr. ${widget.doctorName}"),
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