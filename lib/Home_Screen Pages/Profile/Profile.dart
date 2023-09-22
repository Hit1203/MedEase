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
             Positioned(
               top: 0,
               right: 0,
               left: 0,
                 child: Container(
                   height: 200,
                   color: Colors.red,
                   child: Center(
                     child: Padding(
                       padding: const EdgeInsets.only(top: 90.0),
                       child: CircleAvatar(
                         radius: 40,
                         // child: ,

                       ),
                     ),
                   ),
                 ),
             ),
            ],
          )
        ),
      ),
    );
  }
}
