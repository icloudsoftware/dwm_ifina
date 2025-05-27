import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class AddArea extends StatefulWidget {
  bool? isBack;
  AddArea({this.isBack = true, super.key});

  @override
  State<AddArea> createState() => _AddAreaState();
}

final TextEditingController areaCntrlr = TextEditingController();
final List<String> _names = [];
final createLoanCntrlr = Get.put(CreateLoanController());
String? selectedValue;

class _AddAreaState extends State<AddArea> {
  bool isLoading = false;
  late List<String> lineNames = [];

  void _removeName(String name) {
    setState(() {
      _names.remove(name);
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await createLoanCntrlr.getLines();

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
  Widget build(BuildContext context) {
    final lineNames =
        createLoanCntrlr.lineList.map((e) => e.name).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: widget.isBack == true
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              )
            : SizedBox.shrink(),
        toolbarHeight: 8.h,
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'Add Area',
          style: TextStyle(fontSize: 17.sp, color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 9.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: TextField(
                    controller: areaCntrlr,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      hintText: 'Enter Area',
                      labelText: 'Enter Area',
                    ),
                  ),
                ),
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: DropdownButtonFormField<String>(
                    value: lineNames.contains(selectedValue)
                        ? selectedValue
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Select Line',
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                    items: lineNames.map((name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _names.map((name) {
                    return Chip(
                      deleteIconColor: Colors.white,
                      backgroundColor: Colors.indigo.shade900,
                      label: Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      ),
                      onDeleted: () => _removeName(name),
                    );
                  }).toList(),
                ),
                SizedBox(height: 3.h),
                GestureDetector(
                  onTap: () async {
                    await createLoanCntrlr.createArea(
                      area: areaCntrlr.value.text,
                      line: selectedValue,
                    );
                    areaCntrlr.clear();
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
