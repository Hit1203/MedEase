import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';

import 'Custom_Drawer/drawerFile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    int activeIndex  = -1 ;

    void setActiveIndex(int index) {
      setState(() {
        activeIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make the AppBar background transparent
          elevation: 0, // Remove the shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HomeScreen.Appbar_color1,
                   Colors.grey
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text('MedEase'),
        ),
        drawer: Drawer(
           child : drawer(),
            ),
      ),
    );
  }
}
