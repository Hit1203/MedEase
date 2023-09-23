import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Profile/Doctor/Custom_container.dart';
import '../../../utils/constants.dart';

class patientProfile extends StatefulWidget {
  const patientProfile({super.key});

  @override
  State<patientProfile> createState() => _patientProfileState();
}



class _patientProfileState extends State<patientProfile> {
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
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.4,
                          right: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Color(0xFF3b5999).withOpacity(.4),
                        image: DecorationImage(
                          image: AssetImage("assets/images/Patient.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: MediaQuery.of(context).size.width * 0.3,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              spreadRadius: 2,
                              blurRadius: 10,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: curUser.gender == "Male"
                              ? AssetImage("assets/images/Patient_male.jpg")
                              : AssetImage("assets/images/Patient_female.jpg"),
                          radius: 80,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomContainer(Name: curUser.name.toString(), icon: Icon(Icons.account_box_outlined),),
                        CustomContainer(Name: curUser.email.toString(), icon: Icon(Icons.email)),
                        CustomContainer(Name: "Weight : ${curUser.weight}", icon: Icon(Icons.monitor_weight)),
                        CustomContainer(Name: "Height : ${curUser.height}", icon: Icon(Icons.height)),
                        CustomContainer(Name: "Age : ${curUser.age}", icon: Icon(Icons.timelapse)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
