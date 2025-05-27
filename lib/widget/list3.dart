import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class custom2 extends StatefulWidget {
  const custom2({super.key});

  @override
  State<custom2> createState() => _custom2State();
}

class _custom2State extends State<custom2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    height:13.h,width:42.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
          BoxShadow(
              color: Color(0x19000000),
              blurRadius: 12,
              offset: Offset(1, 5),
              spreadRadius: 0,
            ),
      ],
    
      color: Colors.white
    ),
    child: Padding(
      padding: const EdgeInsets.only(right:40,left: 30,top:8),
      child: Column(
        children: [
          Row(
                    children: [
                     Text("Title ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.indigo.shade900,fontSize:20,),),
                     Spacer(),
                     Text("	Amount ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.indigo.shade900,fontSize:20,),),
                    ],
                   ),
                   SizedBox(height:0.5.h,),
                    Row(children: [
                      Text("Total Loan Given",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
                    ],
                    ),

                    
                    SizedBox(height:1.h,),
        Container(
        height:4.h,width:250.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.indigo.shade900
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Total Expenses 0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:18,),),
            ),SizedBox(width:9.h,),
           
          ],
        )
        ),
                    
                    

        ],
      ),
    ),
    
    

    );
  }
}