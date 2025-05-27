import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/bill_report/bill_view.dart';

class BillReports2 extends StatefulWidget {
  BillReports2({super.key});

  @override
  State<BillReports2> createState() => _BillReports2State();
}

class _BillReports2State extends State<BillReports2> {
  String? selectedPaymentMode;
  final List<String> options = ['Daily', 'Weekly', 'Monthly'];
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;

  DateTime? _endDate;

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
                "Bill Report",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
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
              height: 1.5.h,
            ),
            DropdownButtonFormField<String>(
              value: selectedPaymentMode,
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
                  selectedPaymentMode = newValue;
                });
              },
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => BillViewScreen(
                      fdate: _startDateController.value.text,
                      loanType: selectedPaymentMode,
                      tdate: _endDateController.value.text,
                    ));
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(9.sp)),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
