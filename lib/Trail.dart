import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';

// class Trail extends StatefulWidget {
//   const Trail({super.key});

//   @override
//   State<Trail> createState() => _TrailState();
// }

// class _TrailState extends State<Trail> {
//   final List<String> Trail = [
//     "Due Loans",
//     "MI Loans",
//     "Document Charge",
//     "Broker Commission",
//     "Hand Loan",
//     "Due Interest Collection",
//     "Due Principal Collection",
//     "Due Penalty Collection",
//     "Other Fin Loan",
//     "Loan Int Paid",
//     "Loan Prin Paid",
//     "MI Int Collection",
//     "MI Prin Collection",
//     "Current Accounts",
//     "ARAA Finance (Capital)",
//     "MK (Capital)",
//     "Sidhi Vinayaga Finance (Capital)",
//     "Info (Capital)",
//     "Sri Ganesh Finance (Capital)",
//     "Sri Finance (Capital)",
//     "Infosel Finance (Capital)",
//     "Infosel (Capital)",
//     "Teat (Capital)",
//     "Geetha (Capital)",
//     "Go Nidhi (Capital)",
//     "Cash A/C",
//     "Bank A/C",
//     "Office Rent",
//     "EB Bill",
//     "TEA",
//     "Petrol Expense",
//     "Water Can"
//   ];

//   final List<String> Debit = [
//     "8790200", "", "", "0", "", "", "", "", "", "0",
//     "0", "", "", "0", "", "", "", "", "", "", "",
//     "", "", "", "22691273", "21021500", "25000",
//     "26500", "1650", "1000", "280", "0"
//   ];

//   final List<String> Credit = [
//     "", "16910", "580659", "2840550", "270", "0", "0", "0", "500000",
//     "10000", "500000", "2245000", "1000000", "0", "25000000", "4460000",
//     "200000", "200000", "200000", "14804014", "52557403", "", "", "", "", "",
//     "", "", "", "", "0"
//   ];

//   DateTime startDate = DateTime.now();
//   DateTime endDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: isStartDate ? startDate : endDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() => isStartDate ? startDate = picked : endDate = picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Trial Balance',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.indigo.shade900,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               readOnly: true,
//               onTap: () => _selectDate(context, true),
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(Icons.calendar_month_outlined),
//                 labelText: 'From Date',
//                 hintText: DateFormat('yyyy-MM-dd').format(startDate),
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.h),
//             child: TextFormField(
//               readOnly: true,
//               onTap: () => _selectDate(context, false),
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(Icons.calendar_month_outlined),
//                 labelText: 'To Date',
//                 hintText: DateFormat('yyyy-MM-dd').format(endDate),
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//           ),
//           SizedBox(height: 2.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 1),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 5.h,
//                     decoration: BoxDecoration(
//                       color: Colors.indigo.shade900,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Print tapped!')),
//                       );
//                     },
//                     child: Container(
//                       height: 5.h,
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade700,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Print',
//                           style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 3.h),
//           Text("TRAIL BALANCE",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),),
//           // Container(
//           //   height: 4.h,
//           //   width: 60.w,
//           //   // color: const Color.fromARGB(255, 243, 116, 87),
//           //   child: const Center(
//           //     child: Text(
//           //       "Trial Balance",
//           //       style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//           //     ),
//           //   ),
//           // ),
//           SizedBox(height:1.h),
//           Container(
//             height: 4.h,
//             width: 100.w,
//             color: const Color.fromARGB(255, 180, 113, 113),
//             child: const Row(
             
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("Particulars", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),SizedBox(width:160,),
//                 Text("Debit", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),SizedBox(width:80,),
//                 Text("Credit", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//          Expanded(
//   child: Column(
//     children: [
//       Expanded(
//         child: ListView.builder(
//           itemCount: Trail.length,
//           itemBuilder: (context, index) {
//             final isEven = index.isEven;
//             return Container(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//               color: isEven
//                   ? const Color.fromARGB(255, 249, 193, 184)
//                   : const Color.fromARGB(255, 244, 170, 149),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       Trail[index],
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       (index < Debit.length && Debit[index].isNotEmpty) ? Debit[index] : "0",
//                       style: const TextStyle(fontSize: 16),
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       (index < Credit.length && Credit[index].isNotEmpty) ? Credit[index] : "0",
//                       style: const TextStyle(fontSize: 16),
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       // First additional container
//       Container(
//         height: 50,
//         width: double.infinity,
//         color: Colors.blue,
//         alignment: Alignment.center,
//         child: const Text(
//           "Additional Container 1",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//       // Second additional container
//       Container(
//         height: 50,
//         width: double.infinity,
//         color: Colors.green,
//         alignment: Alignment.center,
//         child: const Text(
//           "Additional Container 2",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     ],
//   ),
// ),

      
      
//         ],
//       ),
//     );
//   }
// }


class Trail extends StatefulWidget {
  const Trail({super.key});

  @override
  State<Trail> createState() => _TrailState();
}

class _TrailState extends State<Trail> {
  final List<String> trail = [
    "Due Loans", "MI Loans", "Document Charge", "Broker Commission", "Hand Loan",
    "Due Interest Collection", "Due Principal Collection", "Due Penalty Collection",
    "Other Fin Loan", "Loan Int Paid", "Loan Prin Paid", "MI Int Collection",
    "MI Prin Collection", "Current Accounts", "ARAA Finance (Capital)", "MK (Capital)",
    "Sidhi Vinayaga Finance (Capital)", "Info (Capital)", "Sri Ganesh Finance (Capital)",
    "Sri Finance (Capital)", "Infosel Finance (Capital)", "Infosel (Capital)",
    "Teat (Capital)", "Geetha (Capital)", "Go Nidhi (Capital)", "Cash A/C",
    "Bank A/C", "Office Rent", "EB Bill", "TEA", "Petrol Expense", "Water Can"
  ];

  final List<String> debit = [
    "8790200", "", "", "0", "", "", "", "", "", "0", "0", "", "", "0", "", "", "", "", "", "", "",
    "", "", "", "22691273", "21021500", "25000", "26500", "1650", "1000", "280", "0"
  ];

  final List<String> credit = [
    "", "16910", "580659", "2840550", "270", "0", "0", "0", "500000", "10000", "500000",
    "2245000", "1000000", "0", "25000000", "4460000", "200000", "200000", "200000",
    "14804014", "52557403", "", "", "", "", "", "", "", "", "", "0"
  ];

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
  preferredSize: Size.fromHeight(100),
  child: Stack(
    children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 120,
          color:Colors.indigo.shade900
        ),
      ),
      Positioned(
        top: 50,
        left: 60,
        child: Text(
          "Trial Balance",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
      body: Column(
        children: [
        
          SizedBox(height:5.h,),

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
              SizedBox(height:3.h,),
          Container(
            height: 3.h,
            width: double.infinity,
            // color: const Color.fromARGB(255, 214, 110, 69),
            child: const Center(
              child: Text(
                "Trial Balance",
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height:1.h),
          Container(
            height: 4.h,
            width: 100.w,
            color: const Color.fromARGB(255, 237, 160, 112),
            child: const Row(
             
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Particulars", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),SizedBox(width:160,),
                Text("Debit", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),SizedBox(width:80,),
                Text("Credit", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: trail.length + 2, // Adding two extra items for additional containers
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                if (index < trail.length) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    color: index.isEven ? Colors.orange.shade200 : Colors.orange.shade100,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(trail[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text((index < debit.length && debit[index].isNotEmpty) ? debit[index] : "0", textAlign: TextAlign.right),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text((index < credit.length && credit[index].isNotEmpty) ? credit[index] : "0", textAlign: TextAlign.right),
                        ),
                      ],
                    ),
                  );
                } else if (index == trail.length) {
                  return Container(
                    height: 4.h,
                    width: double.infinity,
                    color:const Color.fromARGB(255, 149, 187, 102),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Text("Difference in Opening Balalnces", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(width:28.w,),
                        Text("14804014", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 4.h,
                    width: double.infinity,
                    color:const Color.fromARGB(255, 240, 155, 102),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Text("Grand Total", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(width:43.w,),
                        Text("52557403", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),SizedBox(width:6.w,),
                        Text("52557403", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
