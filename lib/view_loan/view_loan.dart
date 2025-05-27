import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class LoanList extends StatefulWidget {
  String? fdate;
  String? tdate;
  String? loantype;

  LoanList({this.fdate, this.loantype, this.tdate, super.key});

  @override
  State<LoanList> createState() => _LoanListState();
}

class _LoanListState extends State<LoanList> {
  final createLoan = Get.put(CreateLoanController());

  Future<void> fetchData() async {
    await createLoan.viewLoan(
      fdate: widget.fdate,
      tdate: widget.tdate,
      loantype: widget.loantype,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Loan List',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (createLoan.isLopading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (createLoan.viewLoanModel.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                LottieBuilder.asset(
                  'asset/animations/no_data.json',
                  height: 25.h,
                )
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Column(
              children: List.generate(
                createLoan.viewLoanModel.length,
                (index) => _buildLoanCard(index),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoanCard(int index) {
    final loan = createLoan.viewLoanModel[index];

    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelText('Name', Colors.black),
                    _labelText('Loan No', Colors.black),
                    _labelText('Phone No', Colors.black),
                    _labelText('Loan Amount', Colors.black),
                    _labelText('Due Amount', Colors.black),
                    _labelText('Status', Colors.black),
                  ],
                ),
                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List.generate(6, (_) => _labelText(':', Colors.black)),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelText(loan.name ?? '', Colors.black),
                    _labelText(loan.hpl ?? '', Colors.black),
                    _labelText(loan.pno ?? '', Colors.black),
                    _labelText(loan.hpamount ?? '', Colors.black),
                    _labelText(loan.dueamt ?? '', Colors.black),
                    _labelText(
                      loan.status ?? '',
                      loan.status == 'Closed' ? Colors.red : Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.8.h),
            Divider(),
            SizedBox(height: 0.8.h),
            GestureDetector(
              onTap: () async {
                await EasyLauncher.call(number: loan.pno ?? '');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Text(
                      'Call',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.call, size: 18.sp, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.8.h,
            ),
            GestureDetector(
              onTap: () async {
                await createLoan.deleteLoan(
                    id: loan.id, loantype: loan.loantype);
                fetchData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.delete, size: 18.sp, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelText(String text, Color? color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: color),
      ),
    );
  }
}
