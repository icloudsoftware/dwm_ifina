import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BillReportWidget extends StatefulWidget {
  String? name;
  String? loanType;
  String? loanNo;
  String? Date;
  String? payment;
  BillReportWidget(
      {this.Date,
      this.loanNo,
      this.loanType,
      this.name,
      this.payment,
      super.key});

  @override
  State<BillReportWidget> createState() => _BillReportWidgetState();
}

class _BillReportWidgetState extends State<BillReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 12,
              offset: Offset(1, 5),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(8.sp)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Labels Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelText('Name'),
              SizedBox(height: 1.h),
              _buildLabelText('Loan No'),
              SizedBox(height: 1.h),
              // _buildLabelText('Loan Type'),
              SizedBox(height: 1.h),
              _buildLabelText('Date'),
              SizedBox(height: 1.h),
              _buildLabelText('Payment'),
            ],
          ),
          SizedBox(width: 8.w),
          // Colon Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 1.5.h),
                child: Text(
                  ':',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 7.w),
          // Values Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildValueText(widget.name ?? ''),
              SizedBox(height: 1.h),
              _buildValueText(widget.loanNo ?? ''),
              SizedBox(height: 1.h),
              // _buildValueText(widget.loanType ?? ''),
              SizedBox(height: 1.h),
              _buildValueText(widget.Date ?? ''),
              SizedBox(height: 1.h),
              _buildValueText(widget.payment ?? ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabelText(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildValueText(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      );
}
