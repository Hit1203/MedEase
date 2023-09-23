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
              height: MediaQuery.of(context).size.height*0.5,
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

            Container(
              height: MediaQuery.of(context).size.height*0.2,

              child: FutureBuilder(
                  future: AppointmentRequests.getVacantSlots(widget.doctorToken!, strDate),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        Text("Unble to connet please again later");
                      }
                      else if(snapshot.hasData){
                        print("res: ${snapshot.data}");

                        List<dynamic> res = snapshot.data["responseData"]["vacant_slots"];
                        print("res type: ${res[0].runtimeType}");


                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: res.map((e) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              child:  FilterChip(
                                  label: Text(slotFormatString("$e"),style: TextStyle(color: Colors.white),),
                                  selected: isSelected,
                                  backgroundColor: Colors.black,
                                  selectedColor: Colors.red,
                                  onSelected: (bool value){
                                    setState(()
                                    {
                                       isSelected = !isSelected ;
                                    }
                                    );}
                              ),
                                // Container(
                                //   height: 30,
                                //   width: 120,
                                //   child: Center(
                                //           child: Text(slotFormatString("$e"), style: TextStyle(fontSize: 20))),
                                //
                                //   decoration: BoxDecoration(
                                //
                                //       border: Border.all()
                                //   )
                                //   ,
                                // ),

                              )).toList(),

                            ),
                          ),
                        );
                      }
                      else {
                        Text("Sorry no slot avaible for the day");
                      }
                    }

                    return Center(child: CircularProgressIndicator(),);
                  }),
            )

          ],
        ),
      ),
    );
  }
}

String slotFormatString(String time){
  print("date: ${DateTime.now().toString()}");
  DateTime sT = DateTime.parse("2001-01-01 $time:00");
  DateTime eT = sT.add(Duration(minutes: 30));

  String formate = "${sT.hour}:${sT.minute==0?'00':sT.minute} - ${eT.hour}:${eT.minute==0?'00':eT.minute}";

  return formate;
}

