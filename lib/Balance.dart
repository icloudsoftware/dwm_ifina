import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:info_fina/costom/Appbar_wave.dart';

class Balance extends StatefulWidget {
  String? name;
  Balance({this.name, super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final List<String> financeList = [
    "Area Finance",
    "MK",
    'sidhi vinayaga finance',
    "Sri Ganesh Finance",
    "sri financ",
    "Infosel Finance",
    "INFOSSEL",
    "Teat",
    "GEETHA",
    "GO NIDHI",
  ];

  final List<String> financeList1 = [
    "500000",
    "10000",
    "500000",
    "2245000",
    "1000000",
    "2500000",
    "4460000",
    "200000",
    "200000",
    "200000",
  ];

  final List<String> finance = [
    "Cash In Hand",
    "Bank Accounts",
    "Loan Customer(s)",
    "MonthlyLoan Customer(s)",
    "Sundry Debtors",
  ];

  final List<String> finance1 = [
    "22691273",
    "42049050",
    "5949650",
    "0",
    "0",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  widget.name ?? '',
                  style: TextStyle(
                    fontSize: 24,
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //     title:Padding(
      //     padding:EdgeInsets.only(right:269),
      //     child: Text('Balance Sheet', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      //   ),
      //   backgroundColor: Colors.indigo.shade900,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 1),
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
                          '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: 44.2.h,
                    height: 5.h,
                    decoration: BoxDecoration(
                        border: Border.all(), color: Colors.yellow.shade100),
                    child: Center(
                        child: Text(
                      "Balance Sheet",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 30, 65, 205)),
                    )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22.6.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.green.shade100),
                        child: Center(
                            child: Text(
                          "Assets",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        width: 22.3.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 237, 185, 172)),
                        child: Center(
                            child: Text(
                          "Liabilities",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22.6.h,
                        height: 4.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 206, 200, 230)),
                        child: Center(
                            child: Row(
                          children: [
                            Text(
                              "Capital Account",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "34315000",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700),
                            ),
                          ],
                        )),
                      ),
                      Container(
                        width: 22.3.h,
                        height: 4.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 237, 172, 193)),
                        child: Center(
                            child: Row(
                          children: [
                            Text(
                              "Current Asset",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 30, 65, 205)),
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Text(
                              "34315000",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 30, 65, 205)),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22.6.h,
                        height: 30.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 206, 200, 230)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    financeList.length,
                                    (index) => Text(
                                          financeList[index],
                                          style: TextStyle(fontSize: 12),
                                        )),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Loan (Liablity)",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Profit & Loss A/c",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Opening Balance",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                Text(
                                  "Current Period",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red.shade600),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 3.4.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    financeList1.length,
                                    (int index) => Text(
                                          financeList1[index],
                                          style: TextStyle(fontSize: 12),
                                        )),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "5514742",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 22.3.h,
                        height: 30.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 237, 172, 193)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    finance.length,
                                    (int index) => Text(
                                          finance[index],
                                          style: TextStyle(fontSize: 12),
                                        ))
                              ],
                            ),
                            SizedBox(
                              width: 2.4.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    finance1.length,
                                    (int index) => Text(
                                          financeList1[index],
                                          style: TextStyle(fontSize: 12),
                                        ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22.6.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.white),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 21.w,
                              child: Text(
                                "Difference in Opening Balalnces",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "35823499",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 22.3.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22.6.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.green.shade100),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "70689973",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 22.3.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 237, 185, 172)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "70689973",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 30, 65, 205)),
                            )
                          ],
                        ),
                      ),
                    ],
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
