import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Profile/Doctor/Custom_container.dart';
import 'package:tic_tech_teo_2023/models/Doctor.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

import 'NonWorkingCustomClass.dart';

class DoctorProfile extends StatefulWidget {
  Doctor? doctor;
  DoctorProfile({this.doctor, super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    print("view Doc: ${widget.doctor!.name}");
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
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(blurRadius: 12, spreadRadius: 4),
                          ],
                          color: const Color(0xFF3b5999).withOpacity(.4),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/profile1.jpg"),
                              fit: BoxFit.fill)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.4,
                            right: MediaQuery.of(context).size.width * 0.8),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          left: MediaQuery.of(context).size.width * 0.3),
                      child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  spreadRadius: 2,
                                  blurRadius: 10)
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage: curUser.gender == "Male"
                                ? const AssetImage("assets/images/male_doctor.jpg")
                                : const AssetImage("assets/images/female_doc.jpg"),
                            radius: 80,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomContainer(
                        Name: widget.doctor!.name.toString(),
                        icon: const Icon(Icons.account_box_outlined),
                      ),
                      // CustomContainer(
                      //     Name: curUser.email.toString(),
                      //     icon: const Icon(Icons.email)),
                      CustomContainer(
                          Name: "${curUser.whStart} - ${curUser.whEnd}",
                          icon: const Icon(Icons.timelapse)),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.4),
                        child: const Text(
                          "Non Working Days : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //todo: add non working days
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
