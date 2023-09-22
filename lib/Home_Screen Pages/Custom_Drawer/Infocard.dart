import 'package:flutter/material.dart';

class Infocard extends StatelessWidget {
  const Infocard({super.key, required this.name, required this.profession, required this.icon});

  final String name, profession;
  final Icon icon ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          icon.icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        profession,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}