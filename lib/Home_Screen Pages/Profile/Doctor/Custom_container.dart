import 'package:flutter/material.dart' ;

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.Name, required this.icon});

  final String Name ;
  final Icon icon ;



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 36.0),
      child: Container(
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 5.0,left: 12),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.circle,
                    ),
                    child:icon,

                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0,left: 12),
                  child: Text(Name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(20),
          border: Border.all(),
          color: Colors.transparent,
        ),
        width: MediaQuery.of(context).size.width*0.85,
        height: MediaQuery.of(context).size.height*0.08,
      ),
    );
  }
}
