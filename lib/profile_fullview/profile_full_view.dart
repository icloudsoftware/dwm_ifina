import 'dart:math' as logger;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:bounce/bounce.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class FullProfileView extends StatefulWidget {
  String? hpl;
  String? loantype;
  FullProfileView({this.hpl, this.loantype, super.key});
  @override
  State<FullProfileView> createState() => _FullProfileViewState();
}

var customerCntrlr = Get.put(CreateLoanController());

class _FullProfileViewState extends State<FullProfileView> {
  Future<void> fetchData() async {
    customerCntrlr.isLopading.value = true;
    // logger.e(" hpl data${widget.hpl}"); // Set loading to true
    await customerCntrlr.fullViewCustomer(
        hpl: widget.hpl, loanType: widget.loantype);

    customerCntrlr.isLopading.value =
        false; // Set loading to false after fetching
  }

  TextEditingController dueAmountController = TextEditingController();
  TextEditingController penaltyController = TextEditingController();

  RxDouble totalAmount = 0.0.obs;
  RxBool isSubmitted = false.obs;
  void calculateTotal() {
    double due = double.tryParse(dueAmountController.text) ?? 0;
    double penalty = double.tryParse(penaltyController.text) ?? 0;
    totalAmount.value = due + penalty;
  }

  // Future<void> generatePdf(String? loanNumber, String? name) async {
  //   try {
  //     final pdf = pw.Document();
  //     final receiptNumber = DateTime.now().millisecondsSinceEpoch.toString();
  //     final dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //     // Create two copies of the PDF
  //     for (int i = 0; i < 1; i++) {
  //       pdf.addPage(
  //         pw.Page(
  //           pageFormat: PdfPageFormat.a4,
  //           build: (pw.Context context) {
  //             return pw.Container(
  //               padding: pw.EdgeInsets.all(16.sp),
  //               child: pw.Column(
  //                 children: [
  //                   pw.Center(
  //                     child: pw.Text(
  //                       "Loan Receipt",
  //                       style: pw.TextStyle(
  //                         fontSize: 36.sp,
  //                         fontWeight: pw.FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   pw.SizedBox(height: 3.h),
  //                   pw.Divider(),
  //                   pw.SizedBox(height: 2.h),

  //                   pw.Table(
  //                     columnWidths: {
  //                       0: pw.FlexColumnWidth(5), // Label column
  //                       1: pw.FlexColumnWidth(2), // Colon column (Fixed width)
  //                       2: pw.FlexColumnWidth(4), // Value column
  //                     },
  //                     children: [
  //                       _buildTableRow("Name", name ?? ""),
  //                       _buildTableRow("Loan No", loanNumber ?? ""),
  //                       _buildTableRow("Date", dateTime),
  //                       _buildTableRow("Due", dueAmountController.text),
  //                       _buildTableRow("Penalty", penaltyController.text),
  //                       _buildTableRow(
  //                           "Total Amnt", totalAmount.value.toString()),
  //                     ],
  //                   ),

  //                   pw.SizedBox(height: 3.h),
  //                   pw.Divider(),
  //                   pw.SizedBox(height: 3.h),
  //                   // Thank You Message
  //                   pw.Center(
  //                     child: pw.Text(
  //                       "Thank you!",
  //                       style: pw.TextStyle(
  //                         fontSize: 36.sp,
  //                         fontWeight: pw.FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     }

  //     // Print the PDF
  //     await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => pdf.save(),
  //     );
  //   } catch (e) {
  //     print("Error generating PDF: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
    // dueAmountController.text = areacocontrol.profileModel.value.dueamt ?? '0';
    // penaltyController.text = areacocontrol.profileModel.value.penamt ?? '0';
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
        title: Text("Profile Full View",
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        backgroundColor: Colors.indigo.shade900,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (customerCntrlr.isLopading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Ensures horizontal centering
              children: [CircularProgressIndicator()],
            ),
          );
        }
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 12,
                            offset: Offset(1, 5),
                            spreadRadius: 0,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 3.h,
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/mans-face-flat-style_90220-2877.jpg?semt=ais_hybrid&w=740'),
                            ),
                            customerCntrlr.customerDetails.value.firstOrNull
                                        ?.status
                                        ?.toLowerCase() ==
                                    'Closed'
                                ? Chip(
                                    color: WidgetStatePropertyAll(Colors.red),
                                    side: BorderSide.none,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 0.1.h),
                                    label: Text(
                                      'Closed',
                                      style: TextStyle(
                                          fontSize: 9.sp, color: Colors.white),
                                    ))
                                : Container()
                          ],
                        ),

                        _iconButton(
                            Icons.phone,
                            "Call",
                            Color(0xFF001292),
                            () async => await EasyLauncher.call(
                                  number: customerCntrlr.customerDetails.value
                                          .firstOrNull?.pno ??
                                      ''
                                          '',
                                )),
                        _iconButton(
                            Icons.message,
                            "Message",
                            Colors.teal,
                            () async => await EasyLauncher.sms(
                                number: customerCntrlr.customerDetails.value
                                        .firstOrNull?.pno ??
                                    'N/A',
                                message: ''
                                    'N/A')),
                        _iconButton(
                            FontAwesomeIcons.whatsapp,
                            "WhatsApp",
                            Colors.green,
                            () async => await EasyLauncher.sendToWhatsApp(
                                phone: customerCntrlr.customerDetails.value
                                        .firstOrNull?.pno ??
                                    '',
                                message: 'Hello')),
                        // _iconButton(
                        //     Icons.location_on,
                        //     "Location",
                        //     Colors.blue,
                        //     () async => await EasyLauncher.url(
                        //         url:
                        //             'https://www.google.com/maps?q=${areacocontrol.profileModel.value.lat}${areacocontrol.profileModel.value.lang}')),
                        // _iconButton(
                        //   Icons.receipt,
                        //   "Receipt",
                        //   Colors.orange,
                        //   () => showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return Dialog(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(16)),
                        //         elevation: 10,
                        //         child: Padding(
                        //           padding: EdgeInsets.all(16),
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Center(
                        //                   child: Text("Loan Receipt",
                        //                       style: TextStyle(
                        //                           fontSize: 20,
                        //                           fontWeight:
                        //                               FontWeight.bold))),

                        //               Divider(),

                        //               _receiptRow(
                        //                   "Name:",
                        //                   customerCntrlr
                        //                           .customerDetails.value.firstOrNull?.name ??
                        //                       ''),
                        //               _receiptRow(
                        //                   "Loan No:",
                        //                   customerCntrlr
                        //                           .customerDetails.value.firstOrNull?.hpl ??
                        //                       ''),
                        //               _receiptRow(
                        //                   "Date:",
                        //                   DateFormat("dd/MM/yyyy")
                        //                       .format(DateTime.now())),

                        //               // Due Amount
                        //               Obx(() => isSubmitted.value
                        //                   ? _receiptRow("Due Amount:",
                        //                       "₹${dueAmountController.text}")
                        //                   : _receiptInputRow(
                        //                       "Due Amount:",
                        //                       dueAmountController,
                        //                       'Enter Amount')),

                        //               // Penalty Amount
                        //               Obx(() => isSubmitted.value
                        //                   ? _receiptRow("Penalty:",
                        //                       "₹${penaltyController.text}")
                        //                   : _receiptInputRow(
                        //                       "Penalty:",
                        //                       penaltyController,
                        //                       'Enter Amount')),

                        //               // Show Total Amount dynamically
                        //               Obx(() => _receiptRow("Total Amount:",
                        //                   "₹${totalAmount.value}",
                        //                   isBold: true,
                        //                   color: Colors.white)),

                        //               SizedBox(height: 12),

                        //               Center(
                        //                 child: ElevatedButton(
                        //                   onPressed: () {
                        //                     // generatePdf(
                        //                     //     areacocontrol
                        //                     //         .profileModel.value.hpl,
                        //                     //     areacocontrol
                        //                     //         .profileModel.value.fname);
                        //                   },
                        //                   child: Text("Print",
                        //                       style: TextStyle(
                        //                           color: Colors.white)),
                        //                   style: ElevatedButton.styleFrom(
                        //                       backgroundColor:
                        //                           Color(0xFF001292)),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  _buildCard("Profile Details", [
                    _infoRow(
                        "Name",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.name ??
                            ''),
                    _infoRow(
                        "Address",
                        [
                          customerCntrlr
                                  .customerDetails.value.firstOrNull?.address ??
                              '',
                          customerCntrlr.customerDetails.value.firstOrNull
                                  ?.address1 ??
                              '',
                          customerCntrlr.customerDetails.value.firstOrNull
                                  ?.address2 ??
                              '',
                        ].where((element) => element.isNotEmpty).join(', ')),
                    _infoRow(
                        "Office Address",
                        [
                          customerCntrlr.customerDetails.value.firstOrNull
                                  ?.oaddress ??
                              'N/A',
                          customerCntrlr.customerDetails.value.firstOrNull
                                  ?.oaddress1 ??
                              'N/A',
                          customerCntrlr.customerDetails.value.firstOrNull
                                  ?.oaddress2 ??
                              'n/A',
                        ].where((element) => element.isNotEmpty).join(', ')),
                    _infoRow(
                        "Area",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.area ??
                            'N/A'),
                    _infoRow(
                        "Profession",
                        customerCntrlr.customerDetails.value.firstOrNull
                                ?.profession ??
                            ''),
                    _infoRow(
                        "phone",
                        customerCntrlr.customerDetails.value.firstOrNull?.pno ??
                            'N/A'),
                    _infoRow(
                        "phone Office",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.pnooffice ??
                            'N/A'),
                    _infoRow(
                        "phone Residency",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.pnoresi ??
                            'N/A'),
                    _infoRow(
                        "Response Date",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.rdate ??
                            'N/A'),
                    _infoRow(
                        "Remarks",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.remarks ??
                            'N/A'),
                    _infoRow(
                        "My Remarks",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.remarks ??
                            'N/A'),
                  ]),
                  SizedBox(height: 2.h),
                  _buildCard("Co-Obligant Details", [
                    // Add spacing between image and text
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 3.h,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-vector/mans-face-flat-style_90220-2877.jpg?semt=ais_hybrid&w=740')),
                        SizedBox(
                          height: 2.h,
                        ),
                        _infoRow(
                            "Name",
                            customerCntrlr.customerDetails.value.firstOrNull
                                    ?.cobname ??
                                'N/A'),
                        _infoRow(
                            "Phone",
                            customerCntrlr.customerDetails.value.firstOrNull
                                    ?.cobpno ??
                                'N/A'),
                        _infoRow(
                            "Address",
                            [
                              customerCntrlr
                                      .customerDetails.value.firstOrNull?.co ??
                                  'N/A',
                              customerCntrlr.customerDetails.value.firstOrNull
                                      ?.co01 ??
                                  'N/A',
                              customerCntrlr.customerDetails.value.firstOrNull
                                      ?.co02 ??
                                  'N/A',
                            ]
                                .where((element) => element.isNotEmpty)
                                .join(', ')),
                        _infoRow(
                            "Work Address",
                            [
                              customerCntrlr
                                      .customerDetails.value.firstOrNull?.cow ??
                                  'N/A',
                              customerCntrlr.customerDetails.value.firstOrNull
                                      ?.cow01 ??
                                  'N/A',
                              customerCntrlr.customerDetails.value.firstOrNull
                                      ?.cow2 ??
                                  'N/A',
                            ]
                                .where((element) => element.isNotEmpty)
                                .join(', ')),
                        _infoRow(
                            "Ref Phone No",
                            customerCntrlr.customerDetails.value.firstOrNull
                                    ?.cobpno11 ??
                                'N/A'),
                      ],
                    ),
                  ]),

                  SizedBox(height: 2.h),
                  // _buildCard("Vehicle Details", [
                  //   _infoRow(
                  //       "Vehicle No.",
                  //       customerCntrlr.customerDetails.value.firstOrNull?.vno ??
                  //           ''),
                  //   _infoRow(
                  //       "Vehicle Name",
                  //       customerCntrlr
                  //               .customerDetails.value.firstOrNull?.vname ??
                  //           ''),
                  //   _infoRow(
                  //       "Model",
                  //       customerCntrlr
                  //               .customerDetails.value.firstOrNull?.model ??
                  //           ''),
                  //   _infoRow(
                  //       "color",
                  //       customerCntrlr
                  //               .customerDetails.value.firstOrNull?.color ??
                  //           ''),
                  //   _infoRow(
                  //       "Broker Select",
                  //       customerCntrlr
                  //               .customerDetails.value.firstOrNull?.bname ??
                  //           ''),
                  // ]),
                  SizedBox(height: 2.h),

                  _buildCard("Loan Details", [
                    _infoRow(
                        "Loan Type.",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.loantype ??
                            'N/A'),
                    _infoRow(
                        "Loan No.",
                        customerCntrlr.customerDetails.value.firstOrNull?.hpl ??
                            'N/A'),
                    _infoRow(
                        "Loan Date",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.hpdate ??
                            'N/A'),
                    _infoRow(
                        "Loan Amount",
                        customerCntrlr.customerDetails.value.firstOrNull
                                ?.hpamount ??
                            'N/A'),
                    _infoRow(
                        "Due Amount",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.dueamt ??
                            'N/A'),
                    _infoRow(
                        "Total Dues",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.duemnt ??
                            'N/A'),
                    _infoRow(
                        "Paid Dues",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.duemnt ??
                            'N/A'),

                    _infoRow(
                        "Total  pending",
                        customerCntrlr
                                .customerDetails.value.firstOrNull?.total ??
                            ''),
                    //    _infoRow("Last Paid",
                    // areacocontrol.profileModel.value.lddate ?? ''),
                    // _infoRow("Last Paid Date",
                    //     areacocontrol.profileModel.value.lddate ?? ''),
                    // _infoRow("Closing Amt",
                    //     areacocontrol.profileModel.value.tpdue ?? ''),
                  ]),

                  SizedBox(height: 3.h), // Space for floating button
                ],
              ),
            ),
            // Positioned(
            //   bottom: 16,
            //   right: 16,
            //   child: FloatingActionButton(
            //     backgroundColor: Style.colors.primary,
            //     child: Icon(
            //       Icons.note_alt_outlined,
            //       color: Style.colors.primaryLight,
            //       size: 19.sp,
            //     ),
            //     onPressed: () {}, // Add remark functionality here
            //   ),
            // ),
          ],
        );
      }),
    );
  }

  Widget _receiptInputRow(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          SizedBox(
            width: 100,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) => calculateTotal(),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget textRow(String label, String value,
    {bool isBold = false, Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text(value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
            )),
      ],
    ),
  );
}

Widget _buildCard(String title, List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          spreadRadius: 1,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full-width blue heading
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: children,
          ),
        ),
      ],
    ),
  );
}

// pw.TableRow _buildTableRow(String label, String value) {
//   return pw.TableRow(
//     children: [
//       pw.Container(
//         padding: pw.EdgeInsets.symmetric(vertical: 5),
//         alignment: pw.Alignment.bottomLeft,
//         child: pw.Text(
//           label,
//           textAlign: pw.TextAlign.right,
//           style: pw.TextStyle(
//               fontSize: 25.sp,
//               fontWeight: pw.FontWeight.bold), // Increase font size
//         ),
//       ),
//       pw.Container(
//         padding: pw.EdgeInsets.symmetric(vertical: 5),
//         alignment: pw.Alignment.center,
//         child: pw.Text(
//           ":",
//           textAlign: pw.TextAlign.center,
//           style: pw.TextStyle(
//               fontSize: 30.sp,
//               fontWeight: pw.FontWeight.bold), // Increase font size
//         ),
//       ),
//       pw.Container(
//         padding: pw.EdgeInsets.symmetric(vertical: 5),
//         alignment: pw.Alignment.centerLeft,
//         child: pw.Text(
//           value,
//           textAlign: pw.TextAlign.left,
//           style: pw.TextStyle(
//             fontSize: 30.sp,
//           ), // Increase font size
//         ),
//       ),
//     ],
//   );
// }

Widget _receiptRow(String label, String value,
    {bool isBold = false, Color color = Colors.black}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color)),
      ],
    ),
  );
}

Widget _infoRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Spacer(),
        SizedBox(
            width: 45.w,
            child: Text(value, style: TextStyle(color: Colors.grey[700]))),
      ],
    ),
  );
}

Widget _iconButton(
    IconData icon, String label, Color color, VoidCallback onPressed) {
  return Column(
    children: [
      IconButton(icon: Icon(icon, color: color), onPressed: onPressed),
      Text(label, style: TextStyle(fontSize: 8.sp, color: Colors.black)),
    ],
  );
}

void main() {
  runApp(GetMaterialApp(home: FullProfileView()));
}
