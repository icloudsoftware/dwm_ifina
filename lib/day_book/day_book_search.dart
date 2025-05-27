import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:info_fina/sample.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:info_fina/day_book/day_book.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/line_view/line_list.dart';
import 'package:info_fina/view_areas/view_areas.dart';
import 'package:info_fina/bill_report/bill_view.dart';
import 'package:info_fina/add_customer/add_customer.dart';

class daybook1 extends StatefulWidget {
  final bool isBack;

  const daybook1({Key? key, this.isBack = false}) : super(key: key);

  @override
  State<daybook1> createState() => _daybook1State();
}

class _daybook1State extends State<daybook1> {
  String? selectedPaymentMode;
  // final List<String> options = ['Daily', 'Weekly', 'Monthly'];
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade900,
          title: Text(
            'day book',
            style: TextStyle(fontSize: 17.sp, color: Colors.white),
          ),

          // leading: widget.isBack == true
          //     ? IconButton(
          //         onPressed: () {
          //           Get.back();
          //         },
          //         icon: Icon(
          //           Icons.arrow_back_ios_new_rounded,
          //           color: Colors.white,
          //         ),
          //       )
          //     : SizedBox.shrink(),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DaybookView()));
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
                ),
              ),
            ],
          ),
        ));
  }
}
