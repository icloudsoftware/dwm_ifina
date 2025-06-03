import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/receipt/receipt_screen.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:info_fina/controller/search_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:info_fina/profile_fullview/profile_full_view.dart';

class searchview extends StatefulWidget {
  String? loanno;
  String? phone;
  String? name;
  String? area;
  String? line;

  searchview(
      {this.loanno, this.phone, this.name, this.area, this.line, super.key});

  @override
  State<searchview> createState() => _searchviewState();
}

bool isLoading = false;

class _searchviewState extends State<searchview> {
  final searchController1 = Get.put(searchController());

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    await searchController1.searchLoans(
      area: widget.area,
      line: widget.line,
      loanno: widget.loanno,
      phone: widget.phone,
      name: widget.name,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final TextEditingController loanNumberController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();
  final TextEditingController loanDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 15.sp,
          ),
        ),
        title: Text(
          'View Loans',
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
        backgroundColor: Colors.indigo.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(10.sp),
              child: ListView.builder(
                itemCount: searchController1.someList.length,
                itemBuilder: (context, index) {
                  var data = searchController1.someList[index];
                  return Bounce(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullProfileView(
                                    hpl: data.hpl,
                                    loantype: data.loantype,
                                  )));
                    },
                    duration: const Duration(milliseconds: 300),
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.h),
                                      Text(
                                        'Name:  ' '${data.name ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        'Loan No: ${data.hpl ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        'Phone: ${data.pno ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        "₹ ${data.pendingamount ?? 'N/A'}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      data.status == 'Closed'
                                          ? Chip(
                                              color: WidgetStatePropertyAll(
                                                  Colors.red.withOpacity(0.7)),
                                              label: Text(
                                                'Closed',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.white),
                                              ))
                                          : GestureDetector(
                                              onTap: () {
                                                Get.to(() => ReceiptScreen(
                                                          loanNumber: data.hpl,
                                                          loanType:
                                                              data.loantype,
                                                        ))!
                                                    .then((value) {
                                                  fetchData();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.w,
                                                    vertical: 0.9.h),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.indigo.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.sp)),
                                                child: Text(
                                                  'Pay Now',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                )
                                // Column(
                                //   children: [
                                //     CircleAvatar(
                                //       backgroundImage:
                                //           AssetImage('assets/images/placeholder.jpg'),
                                //       radius: 4.h,
                                //     ),
                                //     SizedBox(height: 1.h),
                                //   ],
                                // ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  icon: Icons.phone,
                                  label: "Call",
                                  color: Colors.blue,
                                  onPressed: () async {
                                    await EasyLauncher.call(
                                        number: data.pno ?? '');
                                  },
                                ),
                                _buildActionButton(
                                  icon: Icons.message,
                                  label: "Message",
                                  color: Colors.teal,
                                  onPressed: () async {
                                    await EasyLauncher.sms(
                                        number: data.pno ?? '',
                                        message: data.msg ?? '');
                                  },
                                ),
                                _buildActionButton(
                                  icon: FontAwesomeIcons.whatsapp,
                                  label: "WhatsApp",
                                  color: Colors.green,
                                  onPressed: () async {
                                    await EasyLauncher.sendToWhatsApp(
                                        phone: data.pno ?? '',
                                        message: data.msg ?? '');
                                  },
                                ),
                                _buildActionButton(
                                  icon: Icons.location_on,
                                  label: "Location",
                                  color: Colors.blue,
                                  onPressed: () async {
                                    String googleMapsUrl =
                                        'https://www.google.com/maps?q=${data.lat},${data.lang}';
                                    await EasyLauncher.url(url: googleMapsUrl);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showReceiptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Loan Receipt",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                // _buildReceiptRow("Name:", "John Doe"),
                // _buildReceiptRow("Loan No:", "LOAN12345"),
                // _buildReceiptRow("Date:", "01/01/2023"),
                SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Print",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  } 

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isBold = false,
    Color color = Colors.black,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptInputRow(
    String label,
    TextEditingController controller,
    String hintText,
  ) {
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
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
                ),
              ),
            ),
          ],
        ));
  }
}
