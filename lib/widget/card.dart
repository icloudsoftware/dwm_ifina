import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class customlist extends StatefulWidget {
  const customlist({super.key});

  @override
  State<customlist> createState() => _customlistState();
}

class _customlistState extends State<customlist>
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
    height:15.h,width:43.h,
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
      padding: const EdgeInsets.only(left:20,top:40,),
      child: Row(
        children: [
          Column(
            children: [
              Text("6679",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.indigo.shade900,fontSize:25,),),
              Text("Voucher No",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:15,),),
             ],
            ),SizedBox(width:8.w,),
            Column(
              children: [
                Text("particulars:",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:15,),),
                Text("RADHA"),
                Text("Payment",style: TextStyle(fontSize:16,fontWeight:FontWeight.bold,color:Colors.teal,),)
              ],
            ),SizedBox(width:8.w,),
            Column(
              children: [
                Text("Debit:",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:15,),),
                Text("-18000",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.red,fontSize:15,)),

              ],
            ),SizedBox(width:8.w,),
            Column(
              children: [
             Text("Credit:",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:15,),),
             Text("+18000",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.green,fontSize:15,)),

              ],
            )

          
        ],
      ),
    ),
    

    );
  }
}