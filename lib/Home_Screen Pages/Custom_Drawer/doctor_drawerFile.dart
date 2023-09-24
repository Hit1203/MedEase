import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Custom_Drawer/sidemenu_options.dart';
import 'package:tic_tech_teo_2023/LoginRegister/Login_Register_Main_File.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Profile/Doctor/DoctorProfile.dart';
import '../Settings/Doctor/doctor_settings.dart';
import 'Infocard.dart';
import 'card.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorProfile()));
                    },
                      child: Infocard(name: curUser.name.toString(), profession: curUser.isDoctor! ?'Doctor' :'Patient' , icon: Icon(Icons.person),)),
                  Divider(height: 1,),
                  Sidemenuoptions(
                      menuname: 'Waiting List',
                      menuicon: Icon(Icons.list),
                      isActive: activeIndex == 0,
                      index: 0,
                      onTap: () {
                        setActiveIndex(0) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        });
                      }
                  ),

                  Sidemenuoptions(
                      menuname: 'Settings',
                      menuicon: Icon(Icons.settings),
                      isActive: activeIndex == 1,
                      index: 1,
                      onTap: () {
                        setActiveIndex(1) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorSettings()));
                        });
                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Help',
                      menuicon: Icon(Icons.help),
                      isActive: activeIndex == 2,
                      index: 2,
                      onTap: () {
                        setActiveIndex(2) ;
                        launch('http://172.20.10.3:8070/help/',forceWebView: true);
                      }
                  ),
                  Divider(height: 1,),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.34),
                    child: card(name: "Calendar View", color: Colors.grey,),
                  ),
                  Sidemenuoptions(
                      menuname: 'Daily View',
                      menuicon: Icon(Icons.calendar_today),
                      isActive: activeIndex == 3,
                      index: 3,
                      onTap: () {
                        setActiveIndex(3) ;

                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Week View',
                      menuicon: Icon(Icons.calendar_view_week),
                      isActive: activeIndex == 4,
                      index: 4,
                      onTap: () {
                        setActiveIndex(4) ;

                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Month View',
                      menuicon: Icon(Icons.calendar_month),
                      isActive: activeIndex == 5,
                      index: 5,
                      onTap: () {
                        setActiveIndex(5) ;

                      }
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*0.46,left: 15),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.logout,color: Colors.white,),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignupScreen())) ;
                          },
                            child: card(name: 'Sign Out', color: Colors.white,)),
                      ],

                    ),
                  ),



                ],
              ),
            ),

          ),

        ),
      ),
    );
  }
}
