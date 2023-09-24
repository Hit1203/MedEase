import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';

class CustomContainer2 extends StatelessWidget {
  const CustomContainer2({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: curUser.nonWorkingDays?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                curUser.nonWorkingDays![index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
