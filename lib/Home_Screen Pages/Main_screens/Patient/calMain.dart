import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

void main() {
  runApp(CalPatient());
}

class CalPatient extends StatefulWidget {
  String? doctorName;
  String? doctorToken;
  String? patientToken;



  CalPatient({this.doctorName, this.doctorToken, this.patientToken,super.key});

  @override
  State<CalPatient> createState() => _CalPatientState();
}

class _CalPatientState extends State<CalPatient> {
  DateTime today = DateTime.now();
  bool isSelected  = false;
  int? _selectedIndex;
  List<dynamic>? slotList;

  @override
  void initState(){
    super.initState();

  }

  Selectecheep()
  {
    print("asasas") ;
  }

  @override
  Widget build(BuildContext context) {
    print("dt: ${widget.doctorToken}" );

    String strDate = "${today.day}/${today.month}/${today.year}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Dr. ${widget.doctorName}",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.40,
              child: SfCalendar(
                onSelectionChanged: (details){
                  print(details.date) ;
                  setState(() {
                    strDate = "${details.date!.day}/${details.date!.month}/${details.date!.year}";
                  });
                },
                view: CalendarView.month,
                onTap: (CalendarTapDetails details) {
                  // Handle tap on a calendar element here, if needed.
                },

              ),
            ),

            // displaySlots(context),

            const Text("Vacant Slots", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,

                child: slotList==null
                    ?FutureBuilder(
                    future: AppointmentRequests.getVacantSlots(widget.doctorToken!, strDate),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          Text("Unble to connet please again later");
                        }
                        else if(snapshot.hasData){
                          print("res: ${snapshot.data}");

                          List<dynamic> res = snapshot.data["responseData"]["vacant_slots"];
                          slotList = res;
                          print("res type: ${res[0].runtimeType}");




                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.2,
                            child: Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                children: displaySlots(res),
                              ),
                            ),
                          );
                        }
                        else {
                          Text("Sorry no slot avaible for the day");
                        }
                      }

                      return Center(child: CircularProgressIndicator(),);
                    })
                    : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.20,
                      child: Expanded(
                        child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: displaySlots(slotList!),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(child: Container()),

            ElevatedButton(
                child: Text("Confirm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                onPressed: () async {
                  print("${slotList![_selectedIndex!]}");
                  MyAppointment appointment = MyAppointment(
                    doctorId: widget.doctorToken,
                    patientId: widget.patientToken,
                    date: strDate,
                    slot: slotList![_selectedIndex!]
                  );
                  final res = await AppointmentRequests.create(appointment);

                  print("create appo: $res");

                  if(res["responseData"]["created"] == true){
                    //todo add snackbar and back to home
                  }
                  else{
                    //todo failed to create appointment in snackbar
                  }
                }

            )

          ],
        ),
      ),
    );
  }

  List<Widget> displaySlots (List<dynamic> list){
    List<Widget> chips = [];

    for (int i=0; i<list.length; i++){
      Widget item = Padding(
        padding: EdgeInsets.all(1),
        child: ChoiceChip(
          label: Text(slotFormatString("${list[i]}")),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.black,
          selected: _selectedIndex == i,
          selectedColor: Colors.green,

          onSelected: (bool value) {
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

String slotFormatString(String time){
  print("date: ${DateTime.now().toString()}");
  DateTime sT = DateTime.parse("2001-01-01 $time:00");
  DateTime eT = sT.add(Duration(minutes: 30));

  String formate = "${sT.hour}:${sT.minute==0?'00':sT.minute} - ${eT.hour}:${eT.minute==0?'00':eT.minute}";

  return formate;
}


