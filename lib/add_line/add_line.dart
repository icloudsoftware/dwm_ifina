import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class AddLine extends StatefulWidget {
  final bool? isBack;
  AddLine({this.isBack = true, super.key});

  @override
  State<AddLine> createState() => _AddLineState();
}

final TextEditingController lineCntrlr = TextEditingController();
final TextEditingController badloandaysCntlr = TextEditingController();

final List<String> _names = [];
final createLoanCntrlr = Get.put(CreateLoanController());
final List<String> loanTypes = ['daily', 'weekly', 'monthly'];
String? selectedLoanType;

class _AddLineState extends State<AddLine> {
  void _addName(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      _names.add(name.trim());
      lineCntrlr.clear();
    });
  }

  void _removeName(String name) {
    setState(() {
      _names.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'Add Line',
          style: TextStyle(fontSize: 17.sp, color: Colors.white),
        ),
        leading: widget.isBack == true
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              )
            : SizedBox.shrink(),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Loan Type',
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.sp)),
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
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: TextField(
              controller: lineCntrlr,
              onSubmitted: _addName,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                hintText: 'Enter Line',
                labelText: 'Enter Line',
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     Icons.add_circle_rounded,
                //     color: Colors.indigo.shade900,
                //   ),
                //   // onPressed: () => _addName(lineCntrlr.text),
                // ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: TextField(
              controller: badloandaysCntlr,
              // onSubmitted: _addName,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                hintText: 'Bad Loan Days',
                labelText: 'Bad Loan Days',
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     Icons.add_circle_rounded,
                //     color: Colors.indigo.shade900,
                //   ),
                //   // onPressed: () => _addName(lineCntrlr.text),
                // ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _names.map((name) {
              return Chip(
                deleteIconColor: Colors.white,
                backgroundColor: Colors.indigo.shade900,
                label: Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
                onDeleted: () => _removeName(name),
              );
            }).toList(),
          ),
          SizedBox(height: 3.h),
          GestureDetector(
            onTap: () async {
              await createLoanCntrlr.createLine(
                  name: lineCntrlr.value.text,
                  loanType: selectedLoanType,
                  badDays: badloandaysCntlr.value.text);
              lineCntrlr.clear();
              badloandaysCntlr.clear();
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Colors.indigo.shade900,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
