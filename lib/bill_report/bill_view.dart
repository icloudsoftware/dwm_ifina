import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/widget/bill_view.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/controller/active_reports/active_reports_controller.dart';

class BillViewScreen extends StatefulWidget {
  String? fdate;
  String? tdate;
  String? loanType;

  BillViewScreen({this.fdate, this.loanType, this.tdate, super.key});

  @override
  State<BillViewScreen> createState() => _BillViewScreenState();
}

var billCntrlr = Get.put(ActiveReportsController());

class _BillViewScreenState extends State<BillViewScreen> {
  RxBool isLoading = true.obs;
  // Widget _buildTableRow(Map<String, String> data) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
  //     ),
  //     child: Row(
  //       children: [
  //         _TableCell(text: data['name']!),
  //         _TableCell(text: data['line']!),
  //         _TableCell(text: data['area']!),
  //         _TableCell(text: data['loanAmt']!),
  //         _TableCell(text: data['givenAmt']!),
  //         _TableCell(text: data['interest']!),
  //         // _TableCell(text: data['intBal']!),
  //         // _TableCell(text: data['pdBal']!),
  //         // _TableCell(text: data['potBal']!),
  //       ],
  //     ),
  //   );
  // }
  Future<void> fetchData() async {
    isLoading.value = true;
    await billCntrlr.billReport(
      fdate: widget.fdate,
      loantype: widget.loanType,
      tdate: widget.tdate,
    );
    isLoading.value = false;
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
              Positioned(
                top: 45,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // or Get.back()
                  },
                ),
              ),
              Positioned(
                top: 50,
                left: 70,
                child: Text(
                  "Bill List",
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
        body: Obx(() {
          if (isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (billCntrlr.billList.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  LottieBuilder.asset(
                    'asset/animations/no_data.json',
                    height: 25.h,
                  ),
                ],
              ),
            );
          }

          // Controllers for scrollbars
          final verticalController = ScrollController();
          final horizontalController = ScrollController();

          return Scrollbar(
            thumbVisibility: true,
            controller: verticalController,
            child: SingleChildScrollView(
              controller: verticalController,
              child: Scrollbar(
                thumbVisibility: true,
                controller: horizontalController,
                notificationPredicate: (notification) =>
                    notification.depth == 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: horizontalController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      _buildTableHeader(),
                      ...List.generate(
                        billCntrlr.billList.length,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Row(
                            children: [
                              _TableCell(
                                text: '${index + 1}',
                                // You can adjust this width as needed
                              ),
                              _TableCell(
                                text: billCntrlr.billList[index].name ?? 'N/A',
                              ),
                              _TableCell(
                                text: billCntrlr.billList[index].hpl ?? 'N/A',
                              ),
                              _TableCell(
                                text:
                                    billCntrlr.billList[index].paydate2 != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.parse(billCntrlr
                                                .billList[index].paydate2
                                                .toString()))
                                        : 'N/A',
                              ),
                              _TableCell(
                                text:
                                    "₹ ${billCntrlr.billList[index].dueamount ?? 'N/A'}",
                              ),
                              _TableCell(
                                text:
                                    '₹ ${billCntrlr.billList[index].urname ?? 'N/A'}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.indigo.shade900,
      child: Row(
        children: const [
          _TableCell(text: 'S.no', isHeader: true),
          _TableCell(text: 'Name', isHeader: true),
          _TableCell(text: 'Loan No', isHeader: true),
          _TableCell(text: 'Date', isHeader: true),
          _TableCell(text: 'Due Amount', isHeader: true),
          _TableCell(text: 'Payment', isHeader: true),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _TableCell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? Colors.white : Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ));
  }
}
