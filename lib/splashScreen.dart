import 'dart:async';
import 'package:flutter/material.dart' ;

import 'LoginRegister/Login_Register_Main_File.dart';


import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    Timer(Duration(seconds: 8), () {
      print("time out");
      setState(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSignupScreen()));
      });


    });


    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          color: Colors.black ,
        ),

        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 60,backgroundImage: AssetImage("assets/images/App_logo.jpg"),),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,) ,
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 20.0,
              ),
              child: SizedBox(
              width: 250.0,
              child: TextLiquidFill(
                text: 'MedEase',
                waveColor: Colors.blueAccent,
                boxBackgroundColor: Colors.black,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 100.0,

              ),
            )
            ),
          ],
        ),),
      ),
    );
  }
}
