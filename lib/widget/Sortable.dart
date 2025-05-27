import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => isStartDate ? startDate = picked : endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Padding(
          padding:EdgeInsets.only(right:269),
          child: Text('Statements', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  decoration: InputDecoration(
                     suffixIcon: Icon(Icons.calendar_month_outlined),
                    labelText: 'From Date',
                    hintText: DateFormat('yyyy-MM-dd').format(startDate),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month_outlined),
                    
                    labelText: 'To Date',
                    hintText: DateFormat('yyyy-MM-dd').format(endDate),
                    border: OutlineInputBorder(
                      
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
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
                        'Total',
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
            SizedBox(height: 3.h),

            // TabBar inside the body
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.indigo,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Padding(
                  padding: EdgeInsets.only(right:20),
                  child: Tab(child: Text("Credit",style:TextStyle(fontSize:18),)),
                ),
                Tab(child: Text("Debit ",style:TextStyle(fontSize:18),)),
                Tab(child: Text("Denomination",style:TextStyle(fontSize:18),)),
              ],
            ),
            SizedBox(height:5,),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                           Padding(
                                    padding: const EdgeInsets.only(left:6),
                                    child: Container(
                                    height:3.8.h,width:42.1.h,
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
            ),
            SizedBox(width:9.h,),
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
            ),SizedBox(width:20.5.h,),
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
              child: Text("Total Income ",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:18,),),
            ),SizedBox(width:22.h,),
           Text("0",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize:18,),),
          ],
            ) ,
        ),


               

              


                    ],
                  ),
            


                  Center(child: 
                  
                  
                  Column(
                     crossAxisAlignment:CrossAxisAlignment.stretch,
                    
                    children: [
                        Padding(
                                    padding: const EdgeInsets.only(left:2),
                                    child: Container(
                                    height:3.8.h,width:44.1.h,
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
                                    
                                      color: Colors.deepPurple.shade400
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
                                  SizedBox(height:0.1.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.deepPurple.shade200
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Total Loan Given",style:TextStyle(color: Colors.black,fontSize:18,),),
            ),SizedBox(width:20.h,),
            Text("0",style:TextStyle(color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ), SizedBox(height:0.2.h,),
           Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.deepPurple.shade100
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Tea",style:TextStyle(color: Colors.black,fontSize:18,),),
            ),SizedBox(width:31.h,),
            Text("0",style:TextStyle(color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
        SizedBox(height:0.2.h,),
           Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.deepPurple.shade200
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Petrol Expense",style:TextStyle(color: Colors.black,fontSize:18,),),
            ),SizedBox(width:21.7.h,),
            Text("0",style:TextStyle(color: Colors.black,fontSize:18,),),SizedBox(height:1.h,),
          ],
        )
        ),
             SizedBox(height:1.5.h,),
        Container(
        height:4.h,width:43.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
           color: Colors.deepPurple.shade400
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Total Income ",style:TextStyle(color: Colors.white,fontSize:18,),),
           
            ),
            Padding(
              padding: const EdgeInsets.only(left:225),
              child: Text("0 ",style:TextStyle(color: Colors.white,fontSize:18,),),
            ),
           
           
          ],
            ) ,
        ),
        


                      
                    ],
                  )),

                  Center(child: 
                  Column(
                     crossAxisAlignment:CrossAxisAlignment.stretch,
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
    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
