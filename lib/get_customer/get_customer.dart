import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/Create_loan.dart';
import 'package:info_fina/add_area/add_area.dart';
import 'package:info_fina/model/get_customer_model.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:info_fina/controller/getcustomer_controller.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class GetCustomer extends StatefulWidget {
  const GetCustomer({super.key});

  @override
  State<GetCustomer> createState() => _GetCustomerState();
}

class _GetCustomerState extends State<GetCustomer> {
  final GetCuestomerController controller = Get.put(GetCuestomerController());
  final CreateLoanController loanController = Get.put(CreateLoanController());

  Future<void> fetchData() async {
    await controller.getCustomerData();
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Trigger API fetch with loader
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'View Customers',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.customerData.isEmpty) {
          return Center(child: Text("No Customers Found"));
        }

        return ListView.builder(
          itemCount: controller.customerData.length,
          itemBuilder: (context, index) {
            final customer = controller.customerData[index];
            return CustomerCard(
              customer: customer,
              loanController: loanController,
              onDelete: fetchData, // Pass fetch function
            );
          },
        );
      }),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final getcus customer;
  final CreateLoanController loanController;
  final VoidCallback onDelete;

  const CustomerCard({
    required this.customer,
    required this.loanController,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: Offset(2, 2),
              )
            ],
            border: Border(
              left: BorderSide(color: Colors.indigo.shade900, width: 5),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24), // To make space for the cancel button
                _info("Customer: ", customer.name ?? "N/A"),
                _info("Phone: ", customer.pno ?? "N/A"),
                _info("Loan : ", customer.hpl ?? customer.hplt ?? "N/A"),
                _info("Amount: ", "₹${customer.houserent ?? '0'}"),
                _info("Due Date: ", customer.rdate ?? "N/A"),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateLoan(
                              name: customer.name,
                              pno: customer.pno,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.payment, color: Colors.white),
                      label: Text("Make Loan",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await EasyLauncher.call(number: customer.pno ?? '');
                      },
                      icon: Icon(Icons.call, color: Colors.white),
                      label:
                          Text("Call", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10.sp,
          top: 10.sp,
          child: IconButton(
            icon: Icon(Icons.cancel, color: Colors.red),
            onPressed: () async {
              await loanController.deleteCustomer(id: customer.id);
              onDelete(); // Re-fetch customer data after deletion
            },
          ),
        ),
      ],
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
