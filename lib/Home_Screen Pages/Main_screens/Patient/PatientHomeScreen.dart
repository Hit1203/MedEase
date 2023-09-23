import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/models/Doctor.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import '../../../Color_File/colors.dart';
import '../../Custom_Drawer/patient_drawerfile.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

import '../../Profile/Doctor/Profile.dart';
import 'calMain.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchList;

  CustomSearchDelegate(this.searchList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredResults = searchList
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredResults[index]),
          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (context) => SearchResultScreen(result: filteredResults[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedResults = searchList
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestedResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          splashColor: Colors.red,
          title: Text(suggestedResults[index]),
          onTap: () {
            query = suggestedResults[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final String result;

  const SearchResultScreen({required this.result});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: ()
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientHomeScreen())) ;
            },
          ),
          title: Text("${result}"),
        ),
      ),
    );
  }
}


class PatientHomeScreen extends StatefulWidget {
   const PatientHomeScreen({super.key});

  @override

  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {


  bool isThereAppointment = false;

  Appointment appointment = Appointment();
  DateTime today = DateTime.now();

  final List<String>  Uninames = [
    'Dr.D1',
    'Dr.D2',
    'Dr.D3',
    'Dr.D4',
    'Dr.D5',
    'Dr.D6',
    'Dr.D7',
  ] ;

  List<String> filterednames = [];

  @override
  void initState() {
    super.initState();
    filterednames.addAll(Uninames);
  }

  void searchContainers(String query) {
    setState(() {
      filterednames = Uninames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDate = "${today.day}/${today.month}/${today.year}";

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    Uninames,
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          )
        ],
        backgroundColor: Colors.black, // Make the AppBar background transparent
        elevation: 0, // Remove the shadow,
        title: Text('MedEase'),
      ),
      drawer:Drawer(
        child: drawerPatient(),
      ) ,

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
                    else if (snapshot.hasError){
                      //todo
                      return appointmentCard(appointment);
                    }
                  }

                  return Container();
                }
            ),
            
            FutureBuilder(
                future: DoctorRequests.getDoctors(strDate),
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Text("Error");
                    }
                    else if (snapshot.hasData){
                      final Map<String, dynamic> res = snapshot.data as Map<String, dynamic>;
                      List<dynamic> strDoctorList = res["responseData"]["vacant_doctors"];
                      print("type:${strDoctorList[0].runtimeType}");
                      print("type:${strDoctorList[0]}");

                      List<Doctor> doctorList = strDoctorList.map((e) => Doctor.fromJSON(e)).toList();
                      return displayDoctors(context, doctorList);
                      return Text("$res");
                    }
                  }

                  return Center(
                    child: Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.9),
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                  );



                }),

          ],
        ),
      ),
    );
  }
}


Container appointmentCard(Appointment appointment){

  return Container(
    child: Column(
      children: [
        Text("Up Coming Appointment"),

        Text("Doctor: "),
        Text(appointment.doctorId!),

        Text("Date: "),
        Text(appointment.date!),

        Text("Time"),
        Text(appointment.slot!),
      ],
    ),
  );

}



// display doctor..........


Container displayDoctors(context, List<Doctor> doctorList){
  return Container(
    decoration: BoxDecoration(
    ),
    height: MediaQuery.of(context).size.height-100,
    child: ListView.builder(
      itemCount: doctorList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
          child: Container(
            child: Row(
              children: [
                SizedBox(width: 20,),
                Padding(
                  padding:  EdgeInsets.only(bottom: 52.0),
                  child: CircleAvatar(child: Center(child: Icon(Icons.medical_services_outlined,color: Colors.white,),),backgroundColor: Colors.black,radius: 20,),
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.34,top:15),
                      child: Text("Dr. ${doctorList[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        OutlinedButton(
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile())) ;
                            },
                            child: Text("Veiw Profile",style: TextStyle(color: Colors.black),)
                        ),
                        SizedBox(width: 20,),
                        OutlinedButton(
                            onPressed: (){
                              print("doctor: ${doctorList[index]}");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CalPatient(doctorName: doctorList[index].name, doctorToken: doctorList[index].id, patientToken: curUser.userID)));
                            },
                            child: Text("Take Appointment",style: TextStyle(color: Colors.black),)
                        ),
                      ],
                    )

                  ],
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width*0.85,
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),

            ),
          ),
        );
      }),
  );
}