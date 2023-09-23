import 'package:flutter/material.dart' ;

class CustomCon extends StatelessWidget {
  const CustomCon({super.key, required this.Name, required this.icon, required this.padding, required this.ontap});

  final String Name ;
  final Icon icon ;
  final double padding ;
  final VoidCallback ontap ;



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 10.0),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 5.0,left:MediaQuery.of(context).size.width*padding),
                    child: InkWell(
                      onTap: ontap,
                        child: Icon(Icons.edit)
                    )
                  )
                ],
              ),
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



