import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/widget/custom_appbar.dart';
import 'package:info_fina/controller/outstanding_report.dart';

class Outstanding extends StatefulWidget {
  const Outstanding({super.key});

  @override
  State<Outstanding> createState() => _OutstandingState();
}

var outstandingReportCntrlr = Get.put(OutStandingReportController());

class _OutstandingState extends State<Outstanding> {
  final List<String> loanTypes = ['daily', 'weekly', 'monthly'];
  String? selectedLoanType;
  DateTime? fromDate;
  DateTime? toDate;

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.white,
            )),
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'Outstanding Report',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Loan Type',
                  border: OutlineInputBorder(),
                ),
                value: selectedLoanType,
                items: loanTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLoanType = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  // From Date
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _pickDate(context, true),
                      controller: TextEditingController(
                          text: fromDate != null
                              ? dateFormat.format(fromDate!)
                              : ''),
                      decoration: InputDecoration(
                          labelText: 'From Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_month)),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _pickDate(context, false),
                      controller: TextEditingController(
                          text:
                              toDate != null ? dateFormat.format(toDate!) : ''),
                      decoration: InputDecoration(
                          labelText: 'To Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_month)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade900,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () async {
                await outstandingReportCntrlr.outstandingReportData(
                    fromDate: fromDate.toString(),
                    toDate: toDate.toString(),
                    loanType: selectedLoanType);
                // await dcCntrlr.activeReportDcData(
                //   fromDate: _startDateController.value.text,
                //   toDate: _endDateController.value.text,
                // );
              },
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              if (outstandingReportCntrlr.outstandReport.isEmpty) {
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
                return Column(
                  children: [
                    ...List.generate(
                        outstandingReportCntrlr.outstandReport.length,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.8.h),
                              child: LoanDetailsCard(
                                interestBalance: outstandingReportCntrlr
                                    .outstandReport[index].interest,
                                principleBalance: outstandingReportCntrlr
                                    .outstandReport[index].principal,
                                loanNo: outstandingReportCntrlr
                                    .outstandReport[index].loanno,
                                name: outstandingReportCntrlr
                                    .outstandReport[index].name,
                                phone: outstandingReportCntrlr
                                    .outstandReport[index].pno,
                                totalBalance: outstandingReportCntrlr
                                    .outstandReport[index].totalPendingBalance,
                              ),
                            ))
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

class LoanDetailsCard extends StatelessWidget {
  String? name;
  String? phone;
  String? loanNo;
  String? loanAmount;
  String? principleBalance;
  String? interestBalance;
  String? totalBalance;
  LoanDetailsCard(
      {this.interestBalance,
      this.loanAmount,
      this.loanNo,
      this.name,
      this.phone,
      this.principleBalance,
      this.totalBalance,
      super.key});
  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    TextStyle valueStyle = TextStyle(fontSize: 16);
    TextStyle amountStyle = TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingRow(),
            const SizedBox(height: 12),
            _infoRow(Icons.person, 'Name', name ?? '', labelStyle, valueStyle),
            _infoRow(Icons.phone, 'Phone', phone ?? '', labelStyle, valueStyle),
            _infoRow(Icons.credit_card, 'Loan No', loanAmount ?? '', labelStyle,
                valueStyle),
            const SizedBox(height: 12),
            Divider(),
            const SizedBox(height: 12),
            // _amountRow('Loan Amount', loanAmount ?? '', amountStyle),
            _amountRow(
                'Principal Balance', principleBalance ?? '', amountStyle),
            _amountRow('Interest Balance', interestBalance ?? '', amountStyle),
            _amountRow('Total Balance', '₹ ${totalBalance ?? ''}',
                amountStyle.copyWith(fontSize: 20, color: Colors.green[700])),
          ],
        ),
      ),
    );
  }

  Widget _headingRow() {
    return Row(
      children: [
        Text(
          'REPORT',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red, // Red color for the heading
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      TextStyle labelStyle, TextStyle valueStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          SizedBox(width: 10),
          Text('$label: ', style: labelStyle),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }

  Widget _amountRow(String label, String value, TextStyle valueStyle) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: valueStyle,
              textAlign: TextAlign.end, // Align the amount text to the right
            ),
          ],
        ));
  }
}
