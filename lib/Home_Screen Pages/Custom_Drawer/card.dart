import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({super.key, required this.name});

  final String name ;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
    ) ;
  }
}

