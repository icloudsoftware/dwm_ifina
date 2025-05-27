import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:info_fina/settlement/settlement.dart';
import 'package:info_fina/receipt/receipt_screen.dart';
import 'package:info_fina/controller/active_reports/active_reports_controller.dart';

class FullView extends StatefulWidget {
  String? hpl;
  String? loantype;
  FullView({this.hpl, this.loantype, super.key});

  @override
  State<FullView> createState() => _FullViewState();
}

var fullViewCntrlr = Get.put(ActiveReportsController());

class _FullViewState extends State<FullView> {
  Future<void> fetchData() async {
    fullViewCntrlr.isLoading.value = true;
    await fullViewCntrlr.fullView(hpl: widget.hpl, loanType: widget.loantype);
    fullViewCntrlr.isLoading.value = false;
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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text(
          'Full View',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Obx(() {
        if (fullViewCntrlr.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (fullViewCntrlr.fullviewData.isEmpty) {
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
        } else {
          return Column(
            children: [
              SizedBox(height: 3.h),
              fullViewCntrlr.fullviewData.last.status == 'Closed'
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ReceiptScreen(
                                  loanNumber: widget.hpl ?? '',
                                  loanType: widget.loantype ?? '',
                                ))?.then((value) {
                              fetchData();
                              print('Returned from ReceiptScreen');
                            });
                          },
                          child: Container(
                            width: 30.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade900,
                                borderRadius: BorderRadius.circular(8.sp)),
                            child: Center(
                              child: Text(
                                'Receipt',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settlementt(
                                          hpl: widget.hpl,
                                          loantype: widget.loantype,
                                        ))).then((value) {
                              fetchData();
                            });
                          },
                          child: Container(
                            width: 30.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.sp)),
                            child: Center(
                              child: Text(
                                'Settlement',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fullViewCntrlr.fullviewData.length,
                  itemBuilder: (context, index) {
                    final item = fullViewCntrlr.fullviewData[index];
                    return TimelineTile(
                      startChild: Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: Text(
                          item.no ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      alignment: TimelineAlign.manual,
                      lineXY: 0.1,
                      isFirst: index == 0,
                      isLast: index == fullViewCntrlr.fullviewData.length - 1,
                      indicatorStyle: IndicatorStyle(
                        width: 24,
                        color: Colors.indigo.shade900,
                        iconStyle: IconStyle(
                          iconData: Icons.calendar_month,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: LineStyle(
                        color: Colors.indigo.shade900,
                        thickness: 2,
                      ),
                      endChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage(
                                            'https://www.shutterstock.com/image-vector/blond-man-avatar-portrait-young-600nw-2074606570.jpg') // Update with real image path
                                        ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Chip(
                                        side: BorderSide.none,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.2.h),
                                        backgroundColor:
                                            item.status == 'Active' ||
                                                    item.status == 'Closed' ||
                                                    item.status == 'Due'
                                                ? Colors.red.withOpacity(0.6)
                                                : Colors.green.withOpacity(0.6),
                                        label: Text(
                                          item.status == 'Active'
                                              ? 'Not Paid'
                                              : item.status.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                                SizedBox(height: 12),
                                // balanceRow("Interest ", item.amt ?? ''),
                                // balanceRow("Principal Balance", item.pri ?? ''),
                                item.status == 'Paid' ||
                                        item.status == 'Closed' ||
                                        item.status == 'Partially Paid'
                                    ? balanceRow(
                                        "Paid Date",
                                        DateFormat('dd MM yyyy')
                                            .format(item.paydate2!.toLocal()))
                                    : SizedBox.fromSize(),
                                balanceRow("Due Date", item.duedate ?? ''),
                                balanceRow(
                                    "Total Due Amount", item.dueamount ?? ''),
                                // Divider(),
                                // balanceRow("Total Balance", item.bal ?? '',
                                //     isBold: true),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget balanceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
