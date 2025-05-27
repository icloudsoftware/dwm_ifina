import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/add_area/add_area.dart';
import 'package:info_fina/view_loan/view_loan.dart';
import 'package:info_fina/search_loan/search_view.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class searchLoan1 extends StatefulWidget {
  @override
  _searchLoan1State createState() => _searchLoan1State();
}

class _searchLoan1State extends State<searchLoan1> {
  var createLoanCntrlr = Get.put(CreateLoanController());
  String? selectedValue;
  String? selectedArea;

  final TextEditingController loanNumberController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();

  bool isloading = false;

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });
    await createLoanCntrlr.getLines();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    loanNumberController.dispose();
    phoneNoController.dispose();
    customerNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> uniqueAreas = createLoanCntrlr.areaList.toSet().toList();
    final lineNames =
        createLoanCntrlr.lineList.map((e) => e.name).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.indigo.shade900,
          onPressed: () {
            Get.to(() => searchview(
                  loanno: loanNumberController.value.text,
                  phone: phoneNoController.value.text,
                  name: customerNameController.value.text,
                  area: selectedArea,
                  line: selectedValue,
                ));
          }, 
          label: Text(
            'Submit',
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          extendedPadding: EdgeInsets.symmetric(horizontal: 40.w)),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Search Loan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Form(
          child: Column(
            children: [
              _buildRoundedTextField(loanNumberController, 'Loan Number'),
              _buildRoundedTextField(customerNameController, 'Customer Name'),
              _buildRoundedTextField(phoneNoController, 'Phone Number'),
              Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: DropdownButtonFormField<String>(
                  value:
                      lineNames.contains(selectedValue) ? selectedValue : null,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    labelText: 'Select Line',
                    labelStyle: TextStyle(fontSize: 11.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(fontSize: 11.sp, color: Colors.black),
                  items: lineNames.map((name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    setState(() {
                      selectedValue = newValue;
                      selectedArea = null;
                      createLoanCntrlr.areaList = [];
                    });
                    await createLoanCntrlr.getArea(line: newValue);
                    setState(() {
                      createLoanCntrlr.areaList = createLoanCntrlr.areaList
                          .toSet()
                          .toList(); // Deduplicate area list
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value:
                      uniqueAreas.contains(selectedArea) ? selectedArea : null,
                  decoration: InputDecoration(
                    labelText: 'Select Area',
                    labelStyle: TextStyle(fontSize: 11.sp),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  style: TextStyle(fontSize: 11.sp, color: Colors.black),
                  items: uniqueAreas.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedArea = newValue;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRoundedTextField(TextEditingController controller, String label) {
  return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 11.sp),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          labelText: label,
          labelStyle: TextStyle(fontSize: 11.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ));
}
