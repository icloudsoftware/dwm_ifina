import 'dart:convert';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_fina/add_area/add_area.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/ai_screen/ai_screen.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:lottie/lottie.dart' show LottieBuilder;
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class ViewAreas extends StatefulWidget {
  const ViewAreas({super.key});

  @override
  State<ViewAreas> createState() => _ViewAreasState();
}

bool isLoading = false;

class _ViewAreasState extends State<ViewAreas> {
  var areaCntrlr = Get.put(CreateLoanController());

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await areaCntrlr.fetchLineAreaData();
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
        backgroundColor: Colors.indigo.shade900,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
        title: Text(
          'Areas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddArea(isBack: true),
                ),
              ).then((value) {
                fetchData();
              });
            },
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            if (isLoading)
              Column(
                children: [
                  SizedBox(height: 35.h),
                  Center(child: CircularProgressIndicator()),
                ],
              )
            else if (areaCntrlr.lineAreaData.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    LottieBuilder.asset(
                      'asset/animations/no_data.json',
                      height: 25.h,
                    )
                  ],
                ),
              )
            else
              SizedBox(
                height: 70.h,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: areaCntrlr.lineAreaData.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...entry.value.map(
                          (area) => Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                area,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              leading: Icon(
                                Icons.area_chart_outlined,
                                color: Colors.indigo.shade900,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Delete Area",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      content: Text(
                                        "Are you sure you want to delete ?",
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context), // Close dialog
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 1.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                color: Colors.grey
                                                    .withOpacity(0.7)),
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final success =
                                                await areaCntrlr.deleteArea(
                                                    area: area,
                                                    line: entry.key);
                                            setState(() {
                                              areaCntrlr.lineAreaData[entry.key]
                                                  ?.remove(area);
                                              if (areaCntrlr
                                                      .lineAreaData[entry.key]
                                                      ?.isEmpty ??
                                                  false) {
                                                areaCntrlr.lineAreaData
                                                    .remove(entry.key);
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 1.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                color: Colors.red
                                                    .withOpacity(0.7)),
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content:
                                  //         Text("Area deleted successfully"),
                                  //     backgroundColor: Colors.green,
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
