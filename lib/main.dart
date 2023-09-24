import 'package:flutter/material.dart' ;
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Doctor/DoctorHome.dart';
import 'package:tic_tech_teo_2023/models/User.dart';
import 'LoginRegister/Login_Register_Main_File.dart';


void main()
async {
  // final res = await UserRequest.getUser("HOOJIYTCCFLPTFNSBDMO");
  // print("main res: $res");

  runApp(Myapp()) ;
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: LoginSignupScreen(),
      // home: CalPatient(),
      // home: PatientHomeScreen(),
      // home: HomePage(),
      // home: DoctorHome(),
    );
  }
}
