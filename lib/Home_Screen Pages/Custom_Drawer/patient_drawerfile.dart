import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Custom_Drawer/sidemenu_options.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/PatientHomeScreen.dart';
import 'package:tic_tech_teo_2023/LoginRegister/Login_Register_Main_File.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Profile/Doctor/Profile.dart';
import '../Profile/Patient/Patient_profile.dart';
import '../Settings/Patient/patient_settings.dart';
import 'Infocard.dart';
import 'card.dart';

class drawerPatient extends StatefulWidget {
  const drawerPatient({super.key});

  @override
  State<drawerPatient> createState() => _drawerPatientState();
}

class _drawerPatientState extends State<drawerPatient> {

  int activeIndex  = -1 ;

  void setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black
          ),
          width: 310,
          height: double.infinity,

          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>patientProfile()));
                      },
                      child: Infocard(name: curUser.name.toString(), profession: curUser.isDoctor! ? 'Doctor':"Patient", icon: Icon(Icons.person),)),
                  Divider(height: 1,),
                  Sidemenuoptions(
                      menuname: 'Appoinments',
                      menuicon: Icon(Icons.list),
                      isActive: activeIndex == 0,
                      index: 0,
                      onTap: () {
                        setActiveIndex(0) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => patientProfile()));
                        });
                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Upcoming Appointment',
                      menuicon: Icon(Icons.meeting_room_outlined),
                      isActive: activeIndex == 1,
                      index: 1,
                      onTap: () {
                        setActiveIndex(1) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        });
                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Settings',
                      menuicon: Icon(Icons.settings),
                      isActive: activeIndex == 2,
                      index: 2,
                      onTap: () {
                        setActiveIndex(2) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientSettings()));
                        });
                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Help',
                      menuicon: Icon(Icons.help),
                      isActive: activeIndex == 3,
                      index: 3,
                      onTap: () {
                        launch('http://172.20.10.3:8070/help/',forceWebView: true);
                      }
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*0.9,left: 15),
                    child: InkWell(
                      onTap: ()
                      {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignupScreen()));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.logout,color: Colors.white,),
                          SizedBox(width: 10,),
                           card(name: 'Sign Out',),
                        ],

                      ),
                    ),
                  )


                ],
              ),
            ),

          ),

        ),
      ),
    );
  }
}
