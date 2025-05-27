import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/ai_screen/ai_screen.dart';
import 'package:info_fina/receipt/receipt_screen.dart';
import 'package:info_fina/search_loan/search_loan.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:info_fina/profile_fullview/profile_full_view.dart';
import 'package:info_fina/controller/add_customer/add_customer_controller.dart';

class CollectionNew extends StatefulWidget {
  @override
  State<CollectionNew> createState() => _CollectionNewState();
}

class _CollectionNewState extends State<CollectionNew> {
  String dropdownValue = '';
  bool isExpanded = false;
  int selectedTab = 1;
  bool showAllCustomers = false;
  String lastCustomerCode = 'CUST-00543';
  var duesController = Get.put(CreateCostomerController());

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  bool isLoading = false;
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await duesController.todayDues();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AiScreen()));
          },
          backgroundColor: Colors.indigo.shade900,
          child: Image.asset(
            'asset/ai.png',
            color: Colors.white,
            height: 4.5.h,
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF17358B),
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => searchLoan1()));
              },
              icon: Icon(
                Icons.search,
                size: 25.sp,
                color: Colors.white,
              ))
        ],
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            searchQuery.value = value.toLowerCase();
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Column(
              children: [
                if (isExpanded)
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFinancialRow('Bal', '₹0', Colors.green),
                            SizedBox(height: 8),
                            _buildFinancialRow('Bill', '₹500', Colors.black),
                            SizedBox(height: 8),
                            _buildFinancialRow('Coll', '₹100', Colors.green),
                          ],
                        ),
                        SizedBox(width: 130),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDualFinancialRow('T', '₹0', '₹0'),
                            SizedBox(height: 8),
                            _buildFinancialRow('Expense', '₹0', Colors.black),
                            SizedBox(height: 8),
                            _buildFinancialRow('Loan', '₹5000', Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTab('Collect', 1),
                      _buildTab('Collected', 2),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() => _buildTabContent()),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(String label, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: selectedTab == index ? Color(0xFF17358B) : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 2,
            width: 80,
            color:
                selectedTab == index ? Color(0xFF17358B) : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    final allDues = duesController.duesModelData;
    final query = searchQuery.value;

    final filteredDues = allDues.where((item) {
      final matchesTab =
          selectedTab == 1 ? item.status == "Active" : item.status == "Closed";

      final matchesSearch = query.isEmpty ||
          item.name?.toLowerCase().contains(query) == true ||
          item.hpl?.toLowerCase().contains(query) == true;

      return matchesTab && matchesSearch;
    }).toList();

    if (filteredDues.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return ListView.builder(
      itemCount: filteredDues.length,
      itemBuilder: (context, index) {
        final customer = filteredDues[index];
        return Bounce(
          duration: Duration(milliseconds: 300),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullProfileView(
                          hpl: customer.hpl,
                          loantype: customer.loantype,
                        )));
          },
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${customer.name}',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Loan No: ${customer.hpl}',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Due Date: ${customer.duedate}',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Loan Amount: ${customer.hpamount}',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '₹ ${customer.dueamount ?? ''}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: customer.status == 'Active'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Divider(),
                  SizedBox(height: 1.h),
                  customer.status == 'Active'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _iconButton(Icons.phone, "Call", Color(0xFF001292),
                                () async {
                              await EasyLauncher.call(
                                  number: customer.pno ?? '');
                            }),
                            _iconButton(Icons.message, "Message", Colors.teal,
                                () async {
                              await EasyLauncher.sms(
                                  number: customer.pno ?? '', message: 'Hello');
                            }),
                            _iconButton(FontAwesomeIcons.whatsapp, "WhatsApp",
                                Colors.green, () async {
                              await EasyLauncher.sendToWhatsApp(
                                  phone: customer.pno ?? '', message: 'Hello');
                            }),
                            _iconButton(Icons.receipt, "Receipt", Colors.orange,
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiptScreen(
                                    loanNumber: customer.hpl ?? '',
                                    loanType: customer.loantype ?? '',
                                  ),
                                ),
                              ).then((value) {
                                fetchData();
                              });
                              logger.w(customer.loantype ?? '');
                            }),
                          ],
                        )
                      : Chip(
                          backgroundColor: Colors.red.withOpacity(0.7),
                          label: Text(
                            'Closed',
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.white),
                          ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _iconButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 10.sp)),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value', style: TextStyle(color: color)),
      ],
    );
  }

  Widget _buildDualFinancialRow(String label, String left, String right) {
    return Row(
      children: [
        Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Text(left),
        SizedBox(width: 8),
        Text(right),
      ],
    );
  }
}
