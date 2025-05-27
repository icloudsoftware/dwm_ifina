import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/active_report/fullview.dart';
import 'package:info_fina/controller/closed_reports/closed_reports_controller.dart';
import 'package:info_fina/controller/active_reports/active_reports_controller.dart';

class ClosedLoansMc extends StatefulWidget {
  const ClosedLoansMc({super.key});

  @override
  State<ClosedLoansMc> createState() => _ClosedLoansMcState();
}

class _ClosedLoansMcState extends State<ClosedLoansMc> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;

  DateTime? _endDate;
  var closedCntrlr = Get.put(ClosedLoansController());

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _startDateController.text =
              "${picked.day}/${picked.month}/${picked.year}";
        } else {
          _endDate = picked;
          _endDateController.text =
              "${picked.day}/${picked.month}/${picked.year}";
        }
      });
    }
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.indigo.shade900,
      child: Row(
        children: const [
          _TableCell(text: 'Name', isHeader: true),
          _TableCell(text: 'Loan Date', isHeader: true),

          _TableCell(text: 'Line', isHeader: true),
          _TableCell(text: 'Area', isHeader: true),
          _TableCell(text: 'Loan Amt', isHeader: true),
          _TableCell(text: 'Given Amt', isHeader: true),
          _TableCell(text: 'Interest', isHeader: true),
          // _TableCell(text: 'Int Bal', isHeader: true),
          // _TableCell(text: 'PD Bal', isHeader: true),
          // _TableCell(text: 'Pot Bal', isHeader: true),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, String> data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          _TableCell(text: data['name']!),
          _TableCell(text: data['line']!),
          _TableCell(text: data['area']!),
          _TableCell(text: data['loanAmt']!),
          _TableCell(text: data['givenAmt']!),
          _TableCell(text: data['interest']!),
          // _TableCell(text: data['intBal']!),
          // _TableCell(text: data['pdBal']!),
          // _TableCell(text: data['potBal']!),
        ],
      ),
    );
  }

  Future<void> fetchDc() async {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchDc();
  }
     @override
  void dispose() {
    closedCntrlr.closedLoansData.clear(); // Clear the report list
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final sampleData = [
      {
        'name': 'Ravi',
        'line': 'Line 1',
        'area': 'North',
        'loanAmt': '₹1,00,000',
        'givenAmt': '₹95,000',
        'interest': '₹5,000',
        'intBal': '₹2,000',
        'pdBal': '₹1,000',
        'potBal': '₹500',
      },
      {
        'name': 'Priya',
        'line': 'Line 2',
        'area': 'South',
        'loanAmt': '₹80,000',
        'givenAmt': '₹76,000',
        'interest': '₹4,000',
        'intBal': '₹1,000',
        'pdBal': '₹500',
        'potBal': '₹250',
      },
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 17.h,
                  color: Colors.indigo.shade900,
                ),
              ),
              // Back button
              Positioned(
                top: 45,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // or Get.back() if using GetX
                  },
                ),
              ),
              // Title
              Positioned(
                top: 50,
                left: 70, // Adjust if it overlaps with the back button
                child: Text(
                  "Closed Loans - MC",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                // Start Date
                TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  onTap: () => _pickDate(context, true),
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                // End Date
                TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  onTap: () => _pickDate(context, false),
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () async {
                    await closedCntrlr.closdeLoansMc(
                      fromDate: _startDateController.value.text,
                      toDate: _endDateController.value.text,
                    );
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 2.h),

                // Result Section
                Obx(() {
                  if (closedCntrlr.closedLoansData.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        LottieBuilder.asset(
                          'asset/animations/no_data.json',
                          height: 25.h,
                        )
                      ],
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableHeader(),
                            SizedBox(
                              height: 0.9.h,
                            ),
                            ...List.generate(
                              closedCntrlr.closedLoansData.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullView(
                                                hpl: closedCntrlr
                                                    .closedLoansData[index].hpl,
                                              )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index].name ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index]
                                                .hpdate ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index].model ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index].area ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index]
                                                .totalhpamt ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text: closedCntrlr
                                                .closedLoansData[index]
                                                .hpamount ??
                                            'N/A',
                                      ),
                                      _TableCell(
                                        text:
                                            '${closedCntrlr.closedLoansData[index].interest ?? 'N/A'} %',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _TableCell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? Colors.white : Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ));
  }
}
