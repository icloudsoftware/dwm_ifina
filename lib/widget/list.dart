import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Color? colors;
  final String? text;
  final IconData? icons;
  const CustomCard({required this.colors,this .text,this.icons,super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}


class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:423 ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.colors,
      ),
      child: Column(
        children: [
           Padding(
             padding: EdgeInsets.symmetric(vertical:10,horizontal:9),
             child: Padding(
               padding: EdgeInsets.symmetric(vertical:1,horizontal:1),
               child: Row(children: [
                SizedBox(width:4,),
                  Text("	VIVEK 6680",style: TextStyle(color:Colors.black,fontSize:15),),SizedBox(width:30,),
                   Text("201",style: TextStyle(color:Colors.black,fontSize:15),),SizedBox(width:35,),
                   Text("Payment",style: TextStyle(color:Colors.black,fontSize:15),),SizedBox(width:30,),
                    Text("-18000",style: TextStyle(color:Colors.red.shade700,fontSize:15)),SizedBox(width:30,),
                     Text("+8680",style: TextStyle(color:Colors.green.shade800,fontSize:15),)
               ],),
             ),
           )
          
        ],
      ),
    );
  }
}
