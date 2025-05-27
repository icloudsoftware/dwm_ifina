import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCustom extends StatefulWidget {
  const CustomCustom({super.key});

  @override
  State<CustomCustom> createState() => _CustomCustomState();
}

class _CustomCustomState extends State<CustomCustom>
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:6),
              child: Container(
              height:3.8.h,width:43.1.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                    BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 12,
                        offset: Offset(1, 5),
                        spreadRadius: 0,
                      ),
                ],
              
                color: Colors.indigo.shade900
              ),
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal:5.h,vertical:1.w),
                
               child: Row(
                children: [
                 Text("Title ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:20,),),
                 Spacer(),
                 Text("	Amount ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:20,),),
                ],
               ),
             ),
                ),
            ),
            
            
        
              
              ],
              ),
               SizedBox(height:1.h,),
              Container(
             height:4.h,width:43.h,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5),
                color: Colors.indigo.shade100
               ),
              child: Row(
               children: [
                   Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Principal Amount Collected",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:9.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
                ],
             )
              ),
                SizedBox(height:0.1.h,),
                Container(
                 height:4.h,width:43.h,
                     decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                   color: Colors.indigo.shade200
                       ),
                         child: Row(
                       children: [
                        Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text("Interest Amount Collected",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
                        ),
                     SizedBox(width:10.h,),
                     Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
                       ],
                       ),
                       ) ,

                     SizedBox(height:0.1.h,),
                       Container(
                       height:4.h,width:43.h,
                     decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                 color: Colors.indigo.shade100
                ),
                 child: Row(
                children: [
                 Padding(
              padding: const EdgeInsets.only(left:10),
                       child: Text("Savings Amount Collected",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
                 )
            ,SizedBox(width:10.h,),
                 Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
                ],
             )
               ),        
               
                SizedBox(height:0.1.h,),
              Container(
             height:4.h,width:43.h,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                   color: Colors.indigo.shade200
                  ),
                   child: Row(
                  children: [
                    Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Entry Fee",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
                   ),
             SizedBox(width:9.h,),
            
              
          ],
        ),
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.indigo.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Insurance Fee",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:20.h,),
            Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.indigo.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("New Loan Fee",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:9.h,),
            
          ],
        )
        ),
        SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.indigo.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Remittance",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:18,),),
            ),SizedBox(width:9.h,),
           
          ],
        )
        ),
         SizedBox(height:1.5.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.indigo.shade900
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Total Income 0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:18,),),
            ),SizedBox(width:9.h,),
           
          ],
 ) 
        ),



      ],
    );
  
  }
}

 //  Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left:20),
          //       child: Column(
          //         crossAxisAlignment:CrossAxisAlignment.start ,
          //         children: [
          //           Text("Principal Amount Collected",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //            Text("Interest Amount Collected ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //             Text("Savings Amount Collected",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //               Text("Entry Fee",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //                Text("New Loan Fee",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //                 Text("Remittance ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left:10,),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: List.generate(7, (index)=>
          //          Text(
          //           ':' ,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:22),),
          //           )
          //       ),
          //     ),
          //      Padding(
          //        padding:  EdgeInsets.symmetric(horizontal:55,),
          //        child: Padding(
          //          padding: const EdgeInsets.only(right:1),
          //          child: Column(
                             
          //           children: [
          //             Text("00",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //              Text("23 ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
          //               Text("00",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize:20,),),SizedBox(height:1.h,),
                         
          //           ],
          //                    ),
          //        ),
          //      ),
          //   ],
          //  )