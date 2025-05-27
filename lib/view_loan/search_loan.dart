import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/add_line/add_line.dart';
import 'package:info_fina/view_loan/view_loan.dart';

class SearchLoan extends StatefulWidget {
  const SearchLoan({super.key});

  @override
  State<SearchLoan> createState() => _SearchLoanState();
}

final TextEditingController _startDateController = TextEditingController();
final TextEditingController _endDateController = TextEditingController();
DateTime? _startDate;
String? selectloan;
DateTime? _endDate;
final List<String> options = ['Daily', 'Weekly', 'Monthly'];

class _SearchLoanState extends State<SearchLoan> {
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
              "${picked.year}/${picked.month}/${picked.day}";
        } else {
          _endDate = picked;
          _endDateController.text =
              "${picked.year}/${picked.month}/${picked.day}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'View Loan',
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
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
            SizedBox(
              height: 1.5.h,
            ),
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
            SizedBox(
              height: 2.h,
            ),
            DropdownButtonFormField<String>(
              value: selectloan,
              decoration: InputDecoration(
                labelText: 'Select Loantype',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo.shade900),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectloan = newValue;
                });
              },
            ),
            SizedBox(
              height: 4.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoanList(
                              fdate: _startDateController.value.text,
                              tdate: _endDateController.value.text,
                              loantype: selectloan,
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(8.sp)),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
