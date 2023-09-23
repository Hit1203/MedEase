import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Custom_Drawer/sidemenu_options.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

import '../Profile/Doctor/Profile.dart';
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
            gradient: LinearGradient(
              colors: [
                HomeScreen.PrimaryColor,
                Colors.grey,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: 310,
          height: double.infinity,

          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    },
                      child: Infocard(name: curUser.name.toString(), profession: curUser.isDoctor! ?'Patient' :'Doctor' , icon: Icon(Icons.person),)),
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
                      menuname: 'Administative Dashboard',
                      menuicon: Icon(Icons.dashboard),
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
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        });
                      }
                  ),
                  Sidemenuoptions(
                      menuname: 'Help',
                      menuicon: Icon(Icons.help),
                      isActive: activeIndex == 3,
                      index: 3,
                      onTap: () {
                        setActiveIndex(3) ;
                        Future.delayed(Duration(milliseconds: 250), () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        });
                      }
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*0.9),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.logout),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){},
                            child: card(name: 'Sign Out',)),
                      ],

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
