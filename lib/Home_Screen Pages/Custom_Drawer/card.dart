import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({super.key, required this.name, required this.color});

  final String name ;
  final Color color ;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
    ) ;
  }
}

