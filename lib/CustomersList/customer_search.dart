import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/ai_screen/ai_screen.dart';
import 'package:info_fina/CustomersList/view_customers.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class SearchCustomers extends StatefulWidget {
  const SearchCustomers({super.key});

  @override
  State<SearchCustomers> createState() => _SearchCustomersState();
}

var createLoanCntrlr = Get.put(CreateLoanController());
String? selectedValue;
String? selectedArea;

class _SearchCustomersState extends State<SearchCustomers> {
  @override
  Widget build(BuildContext context) {
    List<String> uniqueAreas = createLoanCntrlr.areaList.toSet().toList();
    final lineNames =
        createLoanCntrlr.lineList.map((e) => e.name).toSet().toList();
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
          )
      ),
      appBar: AppBar(
        title: Text(
          'Search Customers',
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        child: Column(
          children: [
            SizedBox(
              height: 13.h,
            ),
            DropdownButtonFormField<String>(
              value: lineNames.contains(selectedValue) ? selectedValue : null,
              decoration: InputDecoration(
                labelText: 'Select Line',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo.shade900),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
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
            SizedBox(
              height: 2.h,
            ),
            DropdownButtonFormField<String>(
              value: uniqueAreas.contains(selectedArea) ? selectedArea : null,
              decoration: InputDecoration(
                labelText: 'Select Area',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo.shade900),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
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
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewCustomers(
                              area: selectedArea,
                              line: selectedValue,
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(8.sp)),
                child: Text(
                  'Search',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
