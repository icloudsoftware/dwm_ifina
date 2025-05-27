import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Custom3 extends StatefulWidget {
  const Custom3({super.key});

  @override
  State<Custom3> createState() => _Custom3State();
}

class _Custom3State extends State<Custom3>
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
    return Column(
      children: [
    
         SizedBox(height:1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color:Colors.green.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("2000",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:9.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color:Colors.green.shade100
        ),
         child:Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("500",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:10.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ) ,

        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade200
        ),
         child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("200",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:10.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ), SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade100
        ),
         child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("100",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:10.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("50",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:11.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("20",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:11.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("10",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:11.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("5",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:12.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("2",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:12.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
         SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("1",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:12.h,),
            Text("x",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("=",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
         SizedBox(height:1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.green.shade400
        ),
        child: Row(
          children: [
            
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:1.h),
              child: Text("Total",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:18,),),
            ),SizedBox(height:1.h,),SizedBox(width:9.h,),
      
          ],
        )
        ),

        

      ],
    );
  
  }
}
