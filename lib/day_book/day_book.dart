import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class DaybookView extends StatefulWidget {
  final bool isBack;

  const DaybookView({Key? key, this.isBack = false}) : super(key: key);

  @override
  State<DaybookView> createState() => _DaybookViewState();
}

class _DaybookViewState extends State<DaybookView> {
  final verticalController = ScrollController();
  final horizontalController = ScrollController();

  final List<Map<String, String>> staticBillList = List.generate(10, (index) {
    return {
      'particulars': 'Opening balance',
      'paymentmode': 'Online',
      'credit': '₹ ${(index + 1) * 1000}',
      'debit': '₹ ${(index + 1) * 800}',
    };
  });


  final List<double> columnWidths = [12, 35, 25, 20, 20]; // In percentage of screen width

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'Daybook',
          style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
                leading: Icon(Icons.arrow_back,color: Colors.white,),
        // leading: widget.isBack
        //     ? IconButton(
        //         onPressed: () => Get.back(),
        //         icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        //       )
        //     : SizedBox.shrink(),
      ),
      body: staticBillList.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  LottieBuilder.asset('asset/animations/no_data.json', height: 25.h),
                  Text('No data available'),
                ],
              ),
            )
          : Scrollbar(
              thumbVisibility: true,
              controller: verticalController,
              child: SingleChildScrollView(
                controller: verticalController,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: horizontalController,
                  notificationPredicate: (notification) => notification.depth == 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: horizontalController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        _buildTableHeader(),
                        ...List.generate(
                          staticBillList.length,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                            ),
                            child: Row(
                              children: [
                                _TableCell(
                                  text: '${index + 1}',
                                  width: columnWidths[0],
                                  align: TextAlign.center,
                                ),
                                _TableCell(
                                  text: staticBillList[index]['particulars']!,
                                  width: columnWidths[1],
                                  align: TextAlign.right, 
                                ),
                                _TableCell(
                                  text: staticBillList[index]['paymentmode']!,
                                  width: columnWidths[2],
                                  align: TextAlign.center,
                                ),
                                _TableCell(
                                  text: staticBillList[index]['credit']!,
                                  width: columnWidths[3],
                                  align: TextAlign.center,
                                ),
                                _TableCell(
                                  text: staticBillList[index]['debit']!,
                                  width: columnWidths[4],
                                  align: TextAlign.center,
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
            ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      color: Colors.indigo.shade900,
      child: Row(
        children: [
          _TableCell(text: 'S.No', isHeader: true, width: columnWidths[0]),
          _TableCell(text: 'Particulars', isHeader: true, width: columnWidths[1]),
          _TableCell(text: 'Payment Mode', isHeader: true, width: columnWidths[2]),
          _TableCell(text: 'Credit', isHeader: true, width: columnWidths[3]),
          _TableCell(text: 'Debit', isHeader: true, width: columnWidths[4]),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final double width;
  final TextAlign? align;

  const _TableCell({
    required this.text,
    this.isHeader = false,
    this.width = 20,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: Text(
        text,
        textAlign: isHeader ? TextAlign.center : (align ?? TextAlign.center),
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
          fontSize: 10.sp,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      )
    );
  }
}