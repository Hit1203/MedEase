import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/Color_File/colors.dart';

class Sidemenuoptions extends StatefulWidget {
  Sidemenuoptions({
    super.key,
    required this.menuname,
    required this.menuicon,
    required this.isActive,
    required this.index,
    required this.onTap,
  });

  final String menuname;
  final Icon menuicon;
  final bool isActive;
  final int index;
  final VoidCallback onTap;

  @override
  State<Sidemenuoptions> createState() => _SidemenuoptionsState();
}

class _SidemenuoptionsState extends State<Sidemenuoptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              height: 65,
              width: widget.isActive ? 305 : 0,
              duration: Duration(milliseconds: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            InkWell(
              onTap: widget.onTap,
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: SizedBox(
                        height: 34,
                        width: 34,
                        child: Icon(
                          widget.menuicon.icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        widget.menuname,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),

              ),
            )
          ],
        ),
      ],
    );
  }
}
