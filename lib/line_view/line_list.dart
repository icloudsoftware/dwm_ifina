import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/model/line_model.dart';
import 'package:info_fina/add_line/add_line.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/ai_screen/ai_screen.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class LinePage extends StatefulWidget {
  @override
  State<LinePage> createState() => _LineListPageState();
}

class _LineListPageState extends State<LinePage> {
  var createLoanCntrlr = Get.put(CreateLoanController());
  bool isLoading = false;

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
    final dailyLines = createLoanCntrlr.lineList
        .where((line) => line.details == 'daily')
        .toList();
    final weeklyLines = createLoanCntrlr.lineList
        .where((line) => line.details == 'weekly')
        .toList();
    final monthlyLines = createLoanCntrlr.lineList
        .where((line) => line.details == 'monthly')
        .toList();

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
        title: Text('Line List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo.shade900,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardScree3()));
          },
          child: Icon(
            Icons.home,
            size: 18.sp,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () async {
              Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(builder: (context) => AddLine()),
              ).then((result) {
                fetchData(); // Refresh data if AddLine returns something
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: 35.h),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : (dailyLines.isEmpty && weeklyLines.isEmpty && monthlyLines.isEmpty)
              ? Center(
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
              : ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildSection("Daily", dailyLines),
                    _buildSection("Weekly", weeklyLines),
                    _buildSection("Monthly", monthlyLines),
                  ],
                ),
    );
  }

  Widget _buildSection(String title, List<LineModel> lines) {
    if (lines.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...lines.map(
          (line) => Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(
                line.name ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Bad Loan Days: ${line.baddebt}',
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.track_changes, color: Colors.indigo.shade900),
              trailing: IconButton(
                onPressed: () async {
                  final lineName = line.name;
                  final success =
                      await createLoanCntrlr.deletLine(line: lineName);

                  setState(() {
                    createLoanCntrlr.lineList
                        .removeWhere((item) => item.name == lineName);
                  });

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text("Line deleted successfully"),
                  //     backgroundColor: Colors.green,
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
