import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/dashboard/dashboard.dart';

class SuccessScreen extends StatefulWidget {
  int? success;
  SuccessScreen({this.success, super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Lottie.asset('asset/animations/success.json', height: 35.h),
            SizedBox(
              height: 3.h,
            ),
            Text(
              widget.success == 1
                  ? 'Loan Process Completed Successfully'
                  : 'Customer Create Completed Successfully',
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 25.h,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Dashboard());
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: Colors.indigo.shade900.withOpacity(0.8)),
                child: Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
