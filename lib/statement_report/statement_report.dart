import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/controller/outstanding_report.dart';

class StatementReport extends StatefulWidget {
  const StatementReport({super.key});

  @override
  State<StatementReport> createState() => _StatementReportState();
}

class _StatementReportState extends State<StatementReport> {
  DateTime? fromDate;
  DateTime? toDate;
  bool isSubmitted = false;

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  var settlementreportCntrlr = Get.put(OutStandingReportController());

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final initialDate =
        isFrom ? fromDate ?? DateTime.now() : toDate ?? DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      setState(() {
        if (isFrom) {
          fromDate = newDate;
        } else {
          toDate = newDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: 30.h,
                  color: Colors.indigo.shade900,
                ),
              ),
              Positioned(
                top: 50,
                left: 60,
                child: Text(
                  "Statement Reports",
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
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                // From Date
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => _pickDate(context, true),
                    controller: TextEditingController(
                      text:
                          fromDate != null ? dateFormat.format(fromDate!) : '',
                    ),
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // To Date
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => _pickDate(context, false),
                    controller: TextEditingController(
                      text: toDate != null ? dateFormat.format(toDate!) : '',
                    ),
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade900,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            onPressed: () async {
              await settlementreportCntrlr.statementReport(
                fdate: fromDate.toString(),
                tdate: toDate.toString(),
              );
              setState(() {
                isSubmitted = true;
              });
            },
            child: Text(
              "Submit",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
              child: isSubmitted
                  ? SingleChildScrollView(
                      child: Card(
                        margin: EdgeInsets.all(16),
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // LEFT COLUMN
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _styledStat(
                                      "No. of Loans",
                                      "${settlementreportCntrlr.activeDaily ?? '0'} /${settlementreportCntrlr.activeWeekly ?? '0'} /${settlementreportCntrlr.activeMonthly ?? '0'}",
                                      icon: Icons.confirmation_number,
                                    ),
                                    SizedBox(height: 20),
                                    _styledStat(
                                      "Loan Amount",
                                      "${settlementreportCntrlr.activeDaily ?? '0'} /${settlementreportCntrlr.activeWeekly ?? '0'} /${settlementreportCntrlr.activeMonthly ?? '0'}", // Example hardcoded, replace if needed
                                      icon: Icons.account_balance_wallet,
                                    ),
                                    SizedBox(height: 20),
                                    _styledStat(
                                      "Closed Loan Amount",
                                      "${settlementreportCntrlr.totalLoanAmountDaily ?? '0'} /${settlementreportCntrlr.totalLoanAmountWeekly ?? '0'} /${settlementreportCntrlr.totalAmountMonthly ?? '0'}",
                                      icon: Icons.lock_outline,
                                    ),
                                  ],
                                ),
                              ),

                              // Vertical Divider
                              Container(
                                width: 1,
                                height: 160,
                                color: Colors.grey.shade400,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                              ),

                              // RIGHT COLUMN
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _styledStat(
                                      "Closed loans",
                                      "${settlementreportCntrlr.closedDaily ?? '0'} /${settlementreportCntrlr.closedWeekly ?? '0'} /${settlementreportCntrlr.closedMonthly ?? ''}",
                                      icon: Icons.closed_caption_off_outlined,
                                    ),
                                    SizedBox(height: 16),
                                    _styledStat(
                                      "Total Collection",
                                      "${settlementreportCntrlr.totalDaily ?? '0'} /${settlementreportCntrlr.totalWeekly ?? '0'} /${settlementreportCntrlr.totalMonthly ?? '0'}",
                                      icon: Icons.summarize,
                                      amountColor: Colors.green[800],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        LottieBuilder.asset(
                          'asset/animations/no_data.json',
                          height: 25.h,
                        )
                      ],
                    )),
        ],
      ),
    );
  }
}

Widget _styledStat(String label, String value,
    {IconData? icon, Color? amountColor}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (icon != null) Icon(icon, size: 20, color: Colors.indigo.shade900),
      if (icon != null) SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 13, color: Colors.grey[900])),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: amountColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
