import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/Create_loan.dart';
import 'package:info_fina/add_customer/add_customer.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';
import 'package:info_fina/controller/add_customer/add_customer_controller.dart';

class ViewCustomers extends StatefulWidget {
  final String? area;
  final String? line;

  ViewCustomers({this.area, this.line, super.key});

  @override
  State<ViewCustomers> createState() => _ViewCustomersState();
}

var createLoanCntrlr = Get.put(CreateLoanController());
final customerlistCntrlr = Get.put(CreateCostomerController());

class _ViewCustomersState extends State<ViewCustomers> {
  
  bool isLoading = true;

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    await customerlistCntrlr.getCustomers(area:widget.area, line:widget.line);
    setState(() => isLoading = false);
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'View Customers',
          style: TextStyle(fontSize: 17.sp, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddCustomer(isback: true));
            },
            icon: Icon(Icons.add_circle_rounded,
                size: 18.sp, color: Colors.white),
          )
        ],
      ),


      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : customerlistCntrlr.customerListData.isEmpty
              ? Center(
                  child: Text(
                    "Customers Not Found",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  itemCount: customerlistCntrlr.customerListData.length,
                  itemBuilder: (context, index) {
                    final customer = customerlistCntrlr.customerListData[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Card(
                        elevation: 4,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _labelText('Name', Colors.black),
                                      _labelText('Phone No', Colors.black),
                                      _labelText('Address', Colors.black),
                                    ],
                                  ),
                                  SizedBox(width: 2.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(3,
                                        (_) => _labelText(':', Colors.black)),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labelText(customer.name ?? 'N/A',
                                            Colors.black),
                                        _labelText(customer.pno ?? 'N/A',
                                            Colors.black),
                                        _labelText(
                                          '${customer.address ?? ''}, ${customer.address1 ?? ''}, ${customer.address2 ?? ''}',
                                          Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.8.h),
                              Divider(),
                              SizedBox(height: 0.8.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateLoan(
                                        isBlank: true,
                                        name: customer.name,
                                        pno: customer.pno,
                                        area: widget.area,
                                        line: widget.line,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.shade900,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Make Loan',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.account_balance,
                                          size: 18.sp, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Add delete functionality
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.delete,
                                          size: 18.sp, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _labelText(String text, Color? color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: color),
      ),
    );
  }
}
