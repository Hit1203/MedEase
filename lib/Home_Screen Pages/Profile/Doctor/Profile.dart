import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Profile/Doctor/Custom_container.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

import 'NonWorkingCustomClass.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  title: Text("Your Profile",style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.black,
                  elevation: 20,
                  leading: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(); // Navigate back when back button is pressed
                    },
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.4,right: MediaQuery.of(context).size.width*0.8),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                          blurRadius: 12,
                          spreadRadius: 4
                        ),],
                          color: Color(0xFF3b5999).withOpacity(.4),
                          image: DecorationImage(
                              image: AssetImage("assets/images/profile1.jpg"),
                              fit: BoxFit.fill
                          )
                      ),
                   width: MediaQuery.of(context).size.width*1,height: MediaQuery.of(context).size.height*0.25,),
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15,left: MediaQuery.of(context).size.width*0.3),
                      child: Container(

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,2),
                              spreadRadius: 2,
                              blurRadius: 10
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                          child: CircleAvatar(
                            backgroundImage: curUser.gender == "Male"
                                ? AssetImage("assets/images/male_doctor.jpg")
                                : AssetImage("assets/images/female_doc.jpg"),
                            radius: 80,
                          )

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width*0.9,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomContainer(Name: curUser.name.toString(), icon: Icon(Icons.account_box_outlined),),
                      CustomContainer(Name: curUser.email.toString(), icon: Icon(Icons.email)),
                      CustomContainer(Name: "${curUser.whStart} - ${curUser.whEnd}", icon: Icon(Icons.timelapse)),
                      SizedBox(height: 20,),
                      Padding(
                        padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*0.4),
                        child: Text("Non Working Days : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      SizedBox(height: 10,),
                     Row(
                       children: [
                         Padding(
                           padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02,left: 12),
                           // child: CustomContainer2(),
                         ),
                       ],
                     )

                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
