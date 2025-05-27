import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/controller/active_reports/active_reports_controller.dart';

class ReceiptScreen extends StatefulWidget {
  String? loanType;
  String ?loanNumber;
  ReceiptScreen({ this.loanNumber,  this.loanType, super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

TextEditingController paymentCntrlr = TextEditingController();
TextEditingController loanTypeCntrlr = TextEditingController();
TextEditingController LoanNumberCntrlr = TextEditingController();
var receiptCntrlr = Get.put(ActiveReportsController());

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loanTypeCntrlr.text = widget.loanType ?? '';
    LoanNumberCntrlr.text = widget.loanNumber ?? '';
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
                "Receipt",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
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
              controller: loanTypeCntrlr,
              readOnly: true,
              // initialValue: widget.hpl ?? "",
              decoration: InputDecoration(
                labelText: "Loan Type",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp)),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: LoanNumberCntrlr,
              readOnly: true,
              // initialValue: widget.hpl ?? "",
              decoration: InputDecoration(
                labelText: "Loan Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp)),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: paymentCntrlr,
              keyboardType: TextInputType.number,
              // initialValue: widget.hpl ?? "",
              decoration: InputDecoration(
                hintText: 'Enter Payment',
                labelText: "Payment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () async {
                await receiptCntrlr.makeReceipt(
                    hpl: widget.loanNumber,
                    user: widget.loanType,
                    payment: paymentCntrlr.value.text);
                Get.back();
                paymentCntrlr.clear();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 15.sp,
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
