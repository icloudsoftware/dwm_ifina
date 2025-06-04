import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';

class ProfitLoss extends StatefulWidget {
  const ProfitLoss({super.key});

  @override
  State<ProfitLoss> createState() => _ProfitLossState();
}

class _ProfitLossState extends State<ProfitLoss> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar:AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  automaticallyImplyLeading: false,
  flexibleSpace: PreferredSize(
    preferredSize: Size.fromHeight(100),
    child: Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 120,
            color: Colors.indigo.shade900,
          ),
        ),
        Positioned(
          top: 50,
          left: 60,
          child: Text(
            "Profit & Loss A/C",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScree3() ));
            },
          ),
        ),
      ],
    ),
  ),
),
      // appBar: AppBar(
      //   title: const Text('Profit & Loss A/C', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      //   backgroundColor: Colors.indigo.shade900,
      // ),
      body: Column(
        children: [
          
          SizedBox(height:10.h,),
           Padding(
                padding:EdgeInsets.symmetric(horizontal:10.h,vertical:1),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'CSV',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Print tapped!')),
                          );
                        },
                        child: Container(
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Print',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height:80,),
          Container(
            height: 3.h,
            width: double.infinity,
            color: Colors.purple.shade700,
            child: const Center(
              child: Text(
                "Profit & Loss A/c ",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
         
          //    Container(
          //   height: 3.h,
          //   width: double.infinity,
          //   color: const Color.fromARGB(255, 234, 126, 200),
          //   child: const Center(
          //     child: Row(
          //       children: [
          //         Text("Particulars",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),SizedBox(width:110,),
          //         Text("Particulars",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
          //       ],
          //     ),
          //   ),
          // )
           Container(
            height: 3.h,
            width: double.infinity,
            color: Colors.deepPurple.shade400,
            child: const Center(
              child: Row(
                children: [
                  SizedBox(width:8,),
                  Text("Particulars",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),SizedBox(width:138,),
                  Text("Particulars",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Column(
                children: [
                  Container(
                    height:30.h,width:28.w,
                  decoration: BoxDecoration(
                    color:Colors.cyan.shade100
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Direct Expences",style:TextStyle(fontWeight:FontWeight.bold,fontSize:14),),
                      Text("Addles",style:TextStyle(fontSize:15),),
                      Text("Interest Paid",style:TextStyle(fontSize:15),),
                      SizedBox(height:8.h,),
                      Text("Gross Profit c/o",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16),),
                      SizedBox(height:5.h,),
                      Text("Indirect Expences",style:TextStyle(fontWeight:FontWeight.bold,fontSize:14),),
                      Text("Nett Profit",style:TextStyle(fontWeight:FontWeight.bold,fontSize:14),),

                    ],
                  ),
                  ),
                ],
                 ),
                  Container(
                     height:30.h,width:22.w,
                   decoration: BoxDecoration(
                     color:Colors.pink.shade100
                   ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                                         
                      children: [
                        Text("54430",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),),
                        Text("0",style:TextStyle(fontSize:18),),
                        Text("0",style:TextStyle(fontSize:18),),
                        SizedBox(height:6.3.h,),
                        Text("543409",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),),
                        Text("597839",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),),
                        SizedBox(height:2.h,),
                        Text("0",style:TextStyle(fontSize:18),),
                        Text("543409",style:TextStyle(fontSize:18),),
                      
                      ],
                     ),
                    ),
                   ),
                   Container(
                     height:30.h,width:28.w,
                   decoration: BoxDecoration(
                     color:Colors.cyan.shade100
                   ),
                   child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                                         
                      children: [
                        Text("Direct Incomes",style:TextStyle(fontWeight:FontWeight.bold,fontSize:14),),
                        Text("Default Income",style:TextStyle(fontSize:13),),
                        Text("Interest income-EMI",style:TextStyle(fontSize:13),),
                        Text("Interest income-WC",style:TextStyle(fontSize:13),),
                        Text("Interest income-DC",style:TextStyle(fontSize:13),),
                        Text("Interest income-MI",style:TextStyle(fontSize:13),),
                        Text("Document income",style:TextStyle(fontSize:13),),

                        SizedBox(height:5.h,),
                        Text("Gross Profit b/f",style:TextStyle(fontWeight:FontWeight.bold,fontSize:15),),
                        Text("Indirect Incomes",style:TextStyle(fontWeight:FontWeight.bold,fontSize:15),),
                       
                      
                      ],
                     ),
                    ),
                   ),
                   Container(
                     height:30.h,width:22.w,
                   decoration: BoxDecoration(
                     color:Colors.pink.shade100
                   ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                                         
                      children: [
                        Text("54430",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),),
                        Text("270",style:TextStyle(fontSize:15),),
                        Text("430745",style:TextStyle(fontSize:14),),
                        Text("48066",style:TextStyle(fontSize:14),),
                        Text("0",style:TextStyle(fontSize:14),),
                         Text("16910",style:TextStyle(fontSize:14),),
                        SizedBox(height:4.h,),
                        Text("597839",style:TextStyle(fontSize:15),),
                        Text("543409",style:TextStyle(fontSize:15),),
                        Text("0",style:TextStyle(fontSize:14),),
                      ],
                     ),
                    ),
                   ),
               ],
          ),
          Container(
            height: 3.h,
            width: double.infinity,
            color: Colors.deepPurple.shade400,
            child: const Center(
              child: Row(
                children: [
                  SizedBox(width:137,),
                  Text("543409	",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),SizedBox(width:162,),
                  Text("543409",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
           
        
        ],
      ),
    );
  }
}