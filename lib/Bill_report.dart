// import 'dart:ui';
// import 'package:sizer/sizer.dart';
// import 'package:flutter/material.dart';
// import 'package:info_fina/Dashboard.dart';
// import 'package:info_fina/widget/csv.dart';
// import 'package:info_fina/costom/Appbar_wave.dart';

// class bill extends StatefulWidget {
//   const bill({super.key});

//   @override
//   State<bill> createState() => _billState();
// }

// class _billState extends State<bill> {
//   final List<Map<String, dynamic>> data = [
//     {
//       "Rcpt No": "217",
//       "Loan No": "9880",
//       "Name": "BABU",
//       "Date": "05-02-2025",
//       "Total": "350",
//       "Options": "Cancel",
//       "Created By": "05:09:20 pm 04/02/25",
//     },
//     {
//       "Rcpt No": "218",
//       "Loan No": "9881",
//       "Name": "SATHYA",
//       "Date": "04-02-2025",
//       "Total": "100",
//       "Options": "Cancel",
//       "Created By": "05:39:06 pm 04/02/25",
//     },
//     {
//       "Rcpt No": "219",
//       "Loan No": "wa1",
//       "Name": "MUTHU",
//       "Date": "04-02-2025",
//       "Total": "100",
//       "Options": "Cancel",
//       "Created By": "05:51:46 pm 04/02/25",
//     }
//   ];

//   final List<Map<String, String>> data1 = [
//     {
//       "Rcpt No": "217",
//       "Loan No": "9880",
//       "Name": "BABU",
//       "Date": "05-02-2025",
//       "Total": "350",
//       "Def Amt": "0",
//       "Created By": "05:09 PM 04/02/25"
//     },
//     {
//       "Rcpt No": "218",
//       "Loan No": "9881",
//       "Name": "SATHYA",
//       "Date": "04-02-2025",
//       "Total": "100",
//       "Def Amt": "0",
//       "Created By": "05:39 PM 04/02/25"
//     },
//     {
//       "Rcpt No": "219",
//       "Loan No": "wa1",
//       "Name": "MUTHU",
//       "Date": "04-02-2025",
//       "Total": "1000",
//       "Def Amt": "0",
//       "Created By": "05:51 PM 04/02/25"
//     },
//   ];

//   final List<String> headings = [
//     "Rcpt No",
//     "Loan No",
//     "Name",
//     "Date",
//     "Total",
//     "Def Amt",
//     "Created By"
//   ];

//   DateTime? _time;
//   final TextEditingController _dateController = TextEditingController();
//   Future<void> _select() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _time ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2030),
//     );

//     if (pickedDate != _time) {
//       setState(() {
//         _time = pickedDate;
//         _dateController.text =
//             "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";
//       });
//     }
//   }

//   DateTime? _selectedOption;
//   DateTime? _selectedOption1;

//   @override
//   void initState() {
//     super.initState();
//     _selectedOption = DateTime.now();
//     _dateController.text =
//         "${_selectedOption!.day}/${_selectedOption!.month}/${_selectedOption!.year}";

//     super.initState();
//     _selectedOption1 = DateTime.now();
//     _dateController1.text =
//         "${_selectedOption1!.day}/${_selectedOption1!.month}/${_selectedOption1!.year}";
//   }

//   DateTime? _Date;
//   final TextEditingController _dateController1 = TextEditingController();
//   Future<void> _select1() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _Date ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2030),
//     );

//     if (pickedDate != _Date) {
//       setState(() {
//         _Date = pickedDate;
//         _dateController1.text =
//             "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         flexibleSpace: PreferredSize(
//           preferredSize: Size.fromHeight(100),
//           child: Stack(
//             children: [
//               ClipPath(
//                 clipper: WaveClipper(),
//                 child: Container(
//                   height: 120,
//                   color: Colors.indigo.shade900,
//                 ),
//               ),
//               Positioned(
//                 top: 50,
//                 left: 60,
//                 child: Text(
//                   "Bill Report",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 left: 10,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => DashboardScree3()));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 3.h,
//           ),
//           // Row(
//           //           children: [
//           //             buildActionButton("Copy"),
//           //             SizedBox(width: 5),
//           //             buildActionButton("CSV"),
//           //             SizedBox(width: 5),
//           //             buildActionButton("Print"),
//           //           ],
//           //         ),
//           SizedBox(
//             height: 3.h,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: TextFormField(
//                     onTap: _select,
//                     controller: _dateController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: _select,
//                         icon: Icon(Icons.calendar_month_outlined),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: TextFormField(
//                     onTap: _select1,
//                     controller: _dateController1,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: _select1,
//                         icon: Icon(Icons.calendar_month_outlined),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 1.h,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 7),
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     value: "All Staff",
//                     items: ["All Staff", "Annamalaiyar Finance", "1"]
//                         .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {},
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo.shade900,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Text(
//                       "Show It",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(
//             height: 8.h,
//           ),

//           Padding(
//             padding: EdgeInsets.all(1),
//             child: DataTable(
//               columnSpacing: 9, // Reduced spacing
//               headingRowHeight: 40, // Smaller header height
//               dataRowHeight: 30, // Smaller row height
//               headingRowColor: MaterialStateColor.resolveWith(
//                   (states) => Colors.deepPurple.shade100),
//               dataRowColor:
//                   MaterialStateColor.resolveWith((states) => Colors.white),
//               border: TableBorder.all(color: Colors.grey),
//               columns: [
//                 DataColumn(
//                     label: _headerText("Rcpt", width: 30)), // Smaller width
//                 DataColumn(label: _headerText("Loan No", width: 50)),
//                 DataColumn(label: _headerText("Name", width: 50)),
//                 DataColumn(label: _headerText("Date", width: 60)),
//                 DataColumn(label: _headerText("Total", width: 40)),
//                 DataColumn(
//                     label: _headerText("Options", width: 50)), // Smaller size
//                 DataColumn(label: _headerText("Created By", width: 70)),
//               ],
//               rows: data.map((item) {
//                 return DataRow(
//                   cells: [
//                     _dataCell(item["Rcpt No"], width: 20),
//                     _dataCell(item["Loan No"], width: 50),
//                     _dataCell(item["Name"], width: 50),
//                     _dataCell(item["Date"], width: 60),
//                     _dataCell(item["Total"], width: 40),
//                     DataCell(SizedBox(
//                       width: 40,
//                       height: 20,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 151, 58, 123),
//                           padding: EdgeInsets.zero,
//                         ),
//                         child: Text("cancel",
//                             style: TextStyle(fontSize: 9, color: Colors.white)),
//                       ),
//                     )),
//                     _dataCell(item["Created By"], width: 70),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _headerText(String text, {double width = 80}) {
//   return SizedBox(
//     width: width,
//     child: Text(
//       text,
//       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

// DataCell _dataCell(String? text, {double width = 80}) {
//   return DataCell(
//     SizedBox(
//       width: width,
//       child: Text(text ?? "-",
//           style: TextStyle(fontSize: 11), textAlign: TextAlign.center),
//     ),
//   );
// }
