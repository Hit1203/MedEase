import 'package:flutter/material.dart' ;
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/PatientHomeScreen.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Profile/Doctor/Custom_container.dart';

import '../../../utils/constants.dart';
import '../Patient/CustomCon.dart';


class DoctorSettings extends StatefulWidget {
  const DoctorSettings({super.key});

  @override
  State<DoctorSettings> createState() => _DoctortSettingsState();
}

class _DoctortSettingsState extends State<DoctorSettings> {
  final  ageControl = TextEditingController();
  int? Age = curUser.age ;

  final weightControl = TextEditingController();
  int? Weigth = curUser.age;

  final heigthControl = TextEditingController();
  int? heigth = curUser.age;

  final passControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Settings",style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
            leading:
            BackButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientHomeScreen())) ;
              },
            )

        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: Column(
            children: [
              CustomCon(
                Name: "Update Password",
                icon: Icon(Icons.password),
                padding: 0.16,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: passControl,
                          decoration: InputDecoration(
                            labelText: "Enter your Updated Password : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Set Password"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },
              ),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 5.0,left: 12),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.circle,
                            ),
                            child:Icon(Icons.holiday_village_sharp),

                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0,left: 12),
                              child: Text("Non Working Days:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0,left: 12),
                              child: Text("${curUser.nonWorkingDays}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                              padding:  EdgeInsets.only(top: 5.0,left:MediaQuery.of(context).size.width*0.14),
                              child: InkWell(
                                  onTap: (){
                                    showDialog(context: context, builder: (context)
                                    {
                                      return AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: TextFormField(
                                            controller: heigthControl,
                                            decoration: InputDecoration(
                                              labelText: "Update Non Working Days : ",
                                              border: OutlineInputBorder(),

                                            ),
                                            keyboardType: TextInputType.number,
                                            maxLines: null,
                                            // onChanged: ,
                                          ),

                                        ),
                                        title: Text("Update Working Days"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {

                                                });
                                              },
                                              child: Text("Save")),
                                        ],
                                      );
                                    }) ;
                                  },
                                  child: Icon(Icons.edit)
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration (
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                  color: Colors.transparent,
                ),
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.11,
              ),
              CustomCon(
                Name: "Working :  ${curUser.height}",
                icon: Icon(Icons.height),
                padding: 0.27,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: heigthControl,
                          decoration: InputDecoration(
                            labelText: "Enter Your Current Height : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Current Heigth"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },),
              CustomCon(
                Name: "Age  : ${curUser.age}",
                icon: Icon(Icons.timelapse),
                padding:0.33,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: ageControl,
                          decoration: InputDecoration(
                            labelText: "Enter Your Current Age : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Current Age"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },),
            ],
          ),
        ),
      ),
    );
  }
}
