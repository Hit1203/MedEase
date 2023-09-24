import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

void main() {
  runApp(CalPatient());
}

class CalPatient extends StatefulWidget {
  String? doctorName;
  String? doctorToken;
  String? patientToken;

  CalPatient({this.doctorName, this.doctorToken, this.patientToken, super.key});

  @override
  State<CalPatient> createState() => _CalPatientState();
}

class _CalPatientState extends State<CalPatient> {
  DateTime today = DateTime.now();
  bool isSelected = false;
  int? _selectedIndex;
  List<dynamic>? slotList;
  String? strDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  @override
  void initState() {
    super.initState();
  }

  // Selectecheep()
  // {
  //   print("asasas") ;
  // }

  @override
  Widget build(BuildContext context) {
    print("dt: ${widget.doctorToken} pt:${widget.patientToken} ${widget.doctorName}");


    // strDate = "${today.day}/${today.month}/${today.year}";

    String? preDate = strDate;

    print("cal Main slotList==null || preDate!=strDate: ${(slotList==null || preDate!=strDate)} \n\tSlotlist:$slotList \n\tstrDate$strDate");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Dr. ${widget.doctorName}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.40,
                child: SfCalendar(

                  showDatePickerButton: true,
                  showTodayButton:true,
                    todayHighlightColor:Colors.black,

                  onSelectionChanged: (details) {
                    print(details.date);
                    setState(() {
                      if(details.date != null)
                      strDate = "${details.date!.day}/${details.date!.month}/${details.date!.year}";
                      _selectedIndex = null;
                    });
                  },
                  view: CalendarView.month,
                  onTap: (CalendarTapDetails details) {
                    // Handle tap on a calendar element here, if needed.
                  },
                ),
              ),
            ),
            Text(
              "Vacant Slots",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,

                child: (slotList==null || preDate!=strDate)
                    ?FutureBuilder(
                    future: AppointmentRequests.getVacantSlots(widget.doctorToken!, strDate!),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          Text("Unble to connet please again later");
                        }
                        else if(snapshot.hasData){
                          print("res: ${snapshot.data}");

                          List<dynamic> res = snapshot
                              .data["responseData"]["vacant_slots"];
                          slotList = res;
                          preDate = strDate;
                          print("cal main slotList ($strDate): $slotList");

                          print("res type: ${res[0].runtimeType}");

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: displaySlots(res),
                            ),
                          );
                        } else {

                          // Handle the case where snapshot.data is null or empty
                          return Text("No data available");
                        }
                      }
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      );
                    })
                    : Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: displaySlots(slotList!),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                "Confirm",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                print("${slotList![_selectedIndex!]}");
                MyAppointment appointment = MyAppointment(
                  doctorId: widget.doctorToken,
                  patientId: widget.patientToken,
                  date: strDate,
                  slot: slotList![_selectedIndex!],
                );

                print("cal main req slot: ${appointment.toJson()}");
                final res = await AppointmentRequests.create(appointment);


                print("create appo: $res");

                if (res["responseData"]["created"] == true) {
                  // Show a success Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Appointment created successfully!"),
                      duration: Duration(seconds: 2), // Optional, set the duration
                    ),
                  );

                  // TODO: Navigate back to the home screen or perform other actions as needed.
                } else {
                  // Show an error Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to create appointment. Please try again."),
                      duration: Duration(seconds: 2), // Optional, set the duration
                    ),
                  );
                }
              },
            )

          ],
        ),
      ),
    );
  }

  List<Widget> displaySlots(List<dynamic> list) {
    List<Widget> chips = [];

    for (int i = 0; i < list.length; i++) {
      Widget item = Padding(
        padding: EdgeInsets.all(1),
        child: ChoiceChip(
          label: Text(slotFormatString("${list[i]}")),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.black,
          selected: _selectedIndex == i,
          selectedColor: Colors.green,

          onSelected: (bool value) {
            print("sel Slot: ${list[i]} ${strDate!}");
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );

      chips.add(item);
    }

    return chips;

  }
}

String slotFormatString(String time) {
  // print("date: ${DateTime.now().toString()}");
  DateTime sT = DateTime.parse("2001-01-01 $time:00");
  DateTime eT = sT.add(Duration(minutes: 30));

  String formate =
      "${sT.hour}:${sT.minute == 0 ? '00' : sT.minute} - ${eT.hour}:${eT.minute == 0 ? '00' : eT.minute}";

  return formate;
}


