import 'package:flutter/material.dart';

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
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                    // image: DecorationImage(
                    //
                    //     image: AssetImage("assets/images/profile_image1"),
                    //     fit: BoxFit.fill)
                ),
             width: MediaQuery.of(context).size.width*1,height: MediaQuery.of(context).size.height*0.25,),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15,left: MediaQuery.of(context).size.width*0.3),
                child: CircleAvatar(radius: 80,),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,left: MediaQuery.of(context).size.width*0.3),
                child: Container(
                  color: Colors.blueAccent,
                  width: MediaQuery.of(context).size.width*1,
                  height: 120,
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
