import 'package:flutter/material.dart';


class CustomListtile extends StatelessWidget {
  const CustomListtile({super.key, required this.Name, required this.icon});
  final Name ;
  final Icon icon ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Row(
          children: [
            Icon(Icons.person),
            Column(
              children: [
                Text(""),
                Text(""),
              ],
            )
          ],
        ),
      )
    );
  }
}
