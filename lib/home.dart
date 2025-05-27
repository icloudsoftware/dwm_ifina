import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:info_fina/view.dart';
import 'package:info_fina/Trail.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/contra.dart';
import 'package:get/route_manager.dart';
import 'package:info_fina/Balance.dart';
import 'package:info_fina/Voucher.dart';
import 'package:info_fina/statement.dart';
import 'package:info_fina/auth/Login.dart';
import 'package:animate_do/animate_do.dart';
import 'package:info_fina/Create_loan.dart';
import 'package:info_fina/profit_loss.dart';
import 'package:info_fina/New_employee.dart';
import 'package:info_fina/New_employee2.dart';
import 'package:info_fina/add_area/add_area.dart';
import 'package:info_fina/add_line/add_line.dart';
import 'package:info_fina/view_loan/view_loan.dart';
import 'package:info_fina/line_view/line_list.dart';
import 'package:info_fina/view_loan/search_loan.dart';
import 'package:info_fina/view_areas/view_areas.dart';
import 'package:info_fina/bill_report/bill_report.dart';
import 'package:info_fina/collections/collections.dart';
import 'package:info_fina/get_customer/get_customer.dart';
import 'package:info_fina/add_customer/add_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_fina/CustomersList/customer_search.dart';
import 'package:info_fina/active_report/active_report_mc.dart';
import 'package:info_fina/active_report/active_report_wc.dart';
import 'package:info_fina/active_report/active_report_dc.dart';
import 'package:info_fina/controller/dashboard_controller.dart';
import 'package:info_fina/statement_report/statement_report.dart';
import 'package:info_fina/closedloans_report/closed_loans_mc.dart';
import 'package:info_fina/closedloans_report/closed_loans_wc.dart';
import 'package:info_fina/closedloans_report/closed_loans_dc.dart';
import 'package:info_fina/outstanding_report/outstanding_report.dart';
import 'package:info_fina/pre_loan_processing/pre_loan_processing.dart';
import 'package:info_fina/monthly_loan_create/monthly_create_loan.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class DashboardScree3 extends StatefulWidget {
  @override
  State<DashboardScree3> createState() => _DashboardScree3State();
}

var dashboardController = Get.put(DashboardController());
var createLoanCntrlr = Get.put(CreateLoanController());

class _DashboardScree3State extends State<DashboardScree3> {
  int _selectedIndex = 3; // Tracks the selected tab index
  bool isLoading = false;
  bool _showCollectionNew = false;

  final List<Widget> _screens = [
    LinePage(),
    ViewAreas(),
    AddCustomer(),
    SearchCustomers()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showCollectionNew = false;
    });
  }

  void _openCollectionNew() {
    setState(() {
      _showCollectionNew = true;
    });
  }

  void _closeCollectionNew() {
    setState(() {
      _showCollectionNew = false;
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    await dashboardController.dahboardCount(user: 'dashboard');

    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> dashboardItems = [
    {
      'title': "Active Loans",
      'value':
          "${dashboardController.loansDetail.value.dailyLoans ?? '0'}/${dashboardController.loansDetail.value.weeklyLoans ?? '0'}/${dashboardController.loansDetail.value.monthlyLoans ?? '0'}" ??
              '0',
      'color': Colors.orange,
      'icon': Icons.check_circle
    },
    {
      'title': "Closed Loans",
      'value':
          "${dashboardController.loansDetail.value.dailyClosedLoans ?? '0'}/${dashboardController.loansDetail.value.weeklyClosedLoans ?? '0'}/${dashboardController.loansDetail.value.monthlyClosedLoans ?? '0'}",
      'color': Colors.redAccent,
      'icon': Icons.cancel
    },
    {
      'title': "Total Loan Amount",
      'value': "${dashboardController.loansDetail.value.totalHpAmount ?? 0} ",
      'color': Colors.purple,
      'icon': Icons.attach_money
    },
    {
      'title': "Principal Balance",
      'value': "${dashboardController.loansDetail.value.principalBalance ?? 0}",
      'color': Colors.blue,
      'icon': Icons.account_balance
    },
    {
      'title': "Closed FD",
      'value': "${dashboardController.loansDetail.value.dailyClosedLoans ?? 0}",
      'color': Colors.teal,
      'icon': Icons.speaker_notes
    },
    {
      'title': "Loan Amount",
      'value':
          "${dashboardController.loansDetail.value.dailyLoansAmount ?? '0'}/${dashboardController.loansDetail.value.weeklyLoansAmount ?? '0'}/${dashboardController.loansDetail.value.weeklyLoansAmount ?? '0'}",
      'color': Colors.green,
      'icon': Icons.check
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          FadeInDown(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.pie_chart, color: Colors.indigo, size: 28),
                      SizedBox(width: 8),
                      Text(
                        "Financial Summary",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black26),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Updated: Today",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                      Icon(Icons.refresh, color: Colors.black45, size: 22),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Column(
            children: dashboardItems.map((item) {
              return MetricTile(
                item: item,
              );
            }).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      extendBody: true,
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 15.h,
        width: 17.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.indigo.shade900, width: 3),
        ),
        child: FloatingActionButton(
          onPressed: _openCollectionNew,
          backgroundColor: Colors.white,
          elevation: 12,
          shape: CircleBorder(),
          child: Icon(Icons.search, size: 40, color: Colors.indigo),
        ),
      ),
      body: _showCollectionNew
          ? WillPopScope(
              onWillPop: () async {
                _closeCollectionNew();
                return false;
              },
              child: CollectionNew(),
            )
          : _selectedIndex == 3
              ? _DashboardContentWithAppBar(
                  isLoading: isLoading,
                  buildDashboardContent: _buildDashboardContent,
                  scaffoldKey: _scaffoldKey,
                )
              : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.indigo.shade900,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.line_axis_rounded),
            label: "Line",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.area_chart),
            label: "Area",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Customer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: "Loan",
          ),
        ],
      ),
    );
  }
}

class _DashboardContentWithAppBar extends StatelessWidget {
  final bool isLoading;
  final Widget Function() buildDashboardContent;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const _DashboardContentWithAppBar({
    required this.isLoading,
    required this.buildDashboardContent,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dashboard-specific app bar
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: 10.h,
          color: Colors.indigo.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    size: 18.sp, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.menu, size: 22.sp, color: Colors.white),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
            ],
          ),
        ),
        // Dashboard content
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : buildDashboardContent(),
        ),
      ],
    );
  }
}

class MetricTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final String? value;
  MetricTile({required this.item, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            item['color'].withOpacity(0.8),
            item['color'].withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: item['color'],
            child: Icon(item['icon'], color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              item['title'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            item['value'],
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: item['color']),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.indigo.shade900,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                ),
                child: Image.asset(
                  "asset/logo.png",
                  height: 250,
                  width: 600,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: 9,
                child: Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Search A/C No or Loan No",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      suffixIcon:
                          Icon(Icons.search, color: Colors.black, size: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                customExpansionTile(Icons.edit, "Entry", Colors.cyanAccent, [
                  customListTile("Create Loan"),
                  customListTile("View Loan"),
                  SizedBox(height: 1.h),
                ]),
                customExpansionTile(
                    Icons.book, "Master", Colors.yellow.shade400, [
                  customListTile("Create Customer"),
                  SizedBox(height: 1.h),
                  customListTile("View Customer"),
                  SizedBox(height: 1.h),
                  customListTile("Line"),
                  SizedBox(height: 1.h),
                  customListTile("Area"),
                ]),
                customListTileAlwaysExpanded(Icons.pending_actions, "Reports", [
                  customListTile("Active Loan List", [
                    "|  Active Loan List - Daily",
                    "|  Active Loan List-Weekly",
                    "|  Active Loan List-EMI"
                  ]),
                  customListTile("Closed Loan Reports", [
                    "|  Closed Loan List - Daily",
                    "|  Closed Loan List - weekly",
                    "|  Closed Loan List - EMI"
                  ]),
                  customListTile("Outstanding Report"),
                  customListTile("Statement Report"),
                  customListTile("Bill Report"),
                  customListTile("Total Loan  Report"),
                  customListTile("Today Due Report"),
                  customListTile("COllection or Billing Report"),
                  customListTile("Delayed Paid Report"),
                  customListTile("On date paid Report"),
                  customListTile("Interest pending Report"),
                  customListTile("Customer Report"),
                  customListTile("Due analysis Report"),
                  customListTile("Line Wise pending Report"),
                  customListTile("Loan against collection Report"),
                  customListTile("Customer status report Report"),
                  customListTile("Investment Report"),
                  customListTile("Expense Summary Report"),
                  customListTile("Income Summary Report"),
                  customListTile("Profit/Loss Report"),
                ]),

                // customExpansionTile(
                //     Icons.pending_actions, "Reports", Colors.cyan, [
                //   customListTile("Active Loan List", [
                //     "|  Active Loan List - Daily",
                //     "|  Active Loan List-Weekly",
                //     "|  Active Loan List-EMI"
                //   ]),
                //   customListTile("Closed Loan Reports", [
                //     "|  Closed Loan List - Daily",
                //     "|  Closed Loan List - weekly",
                //     "|  Closed Loan List - EMI"
                //   ]),

                //   customListTile("Outstanding Report"),
                //   customListTile("Statement Report"),
                //   customListTile("Bill Report"),
                //   customListTile("Total Loan  Report"),
                //   customListTile("Today Due Report"),
                //   customListTile("COllection or Billing Report"),
                //   customListTile("Delayed Paid Report"),
                //   customListTile("On date paid Report"),
                //   customListTile("Interest pending Report"),
                //  customListTile("Customer Report"),
                //   customListTile("Due analysis Report"),
                //   customListTile("Line Wise pending Report"),
                //   customListTile("Loan against collection Report"),
                //   customListTile("Customer status report Report"),
                //   customListTile(" Investment Report"),
                //   customListTile("Expense Summary Report"),
                //   customListTile("Income Summary Report"),
                //   customListTile("Profit/Loss Report"),
                // ]),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customExpansionTile(
      IconData icon, String title, Color iconColor, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      children: children,
    );
  }

  Widget customListTile(String title, [List<dynamic>? subItems]) {
    bool isHovered = false;
    bool isExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (subItems == null || subItems.isEmpty) {
                  navigateToScreen(context, title);
                } else {
                  setState(() => isExpanded = !isExpanded);
                }
              },
              child: MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: Container(
                  color: isHovered ? Colors.red : Colors.transparent,
                  padding: EdgeInsets.only(left: 7.w, top: 1.h, bottom: 1.h),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subItems != null && subItems.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 1.w),
                          child: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.white,
                            size: 2.h,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (isExpanded && subItems != null) ...[
              SizedBox(height: 1.h),
              ...subItems.map((item) {
                if (item is Widget) return item;
                if (item is String) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10.w, bottom: 0.8.h),
                    child: GestureDetector(
                      onTap: () => navigateToScreen(context, item),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink(); // fallback for unexpected types
              }).toList(),
            ],
          ],
        );
      },
    );
  }

  Widget customListTileAlwaysExpanded(IconData icon, String title,
      [List<dynamic>? subItems] // Accept both String and Widget
      ) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Container(
                color: isHovered ? Colors.red : Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.red,
                      size: 2.5.h,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (subItems != null && subItems.isNotEmpty) ...[
              SizedBox(height: 1.h),
              ...subItems.map((item) {
                if (item is Widget) return item;
                if (item is String) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10.w, bottom: 0.8.h),
                    child: GestureDetector(
                      onTap: () => navigateToScreen(context, item),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }).toList(),
            ],
          ],
        );
      },
    );
  }

  void navigateToScreen(BuildContext context, String title) {
    if (title == "Balance Sheet") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Balance()));
    } else if (title == "Bill Report") {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BillReports2()));
    } else if (title == "Create Loan - DC") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CreateLoan()));
    } else if (title == "New Employee") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => NewEmployee()));
    } else if (title == "staff Details") {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => NewEmployee2()));
    } else if (title == "Profit & Loss") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfitLoss()));
    } else if (title == "Statement") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Statement()));
    } else if (title == "Trial Balance") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Trail()));
    } else if (title == "Day Book") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LOAN()));
    } else if (title == "Voucher") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Vouchers()));
    } else if (title == "Create") {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => PreLoanProccessing()));
    } else if (title == "Create Loan") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CreateLoan(
                    isBlank: false,
                  )));
    } else if (title == "Create Loan - AUTO EMI") {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => MonthlyCollections()));
    } else if (title == "Line") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddLine()));
    } else if (title == "Area") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddArea()));
    } else if (title == '|  Active Loan List - Daily') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ActiveReportDc()));
    } else if (title == '|  Active Loan List-Weekly') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ActiveReportWc()));
    } else if (title == '|  Active Loan List-EMI') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ActiveReportMc()));
    } else if (title == '|  Closed Loan List - Daily') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ClosedLoansDc()));
    } else if (title == '|  Closed Loan List - weekly') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ClosedLoansWc()));
    } else if (title == '|  Closed Loan List - EMI') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ClosedLoansMc()));
    } else if (title == 'Bill Report') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BillReports2()));
    } else if (title == 'Outstanding Report') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Outstanding()));
    } else if (title == 'Statement Report') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StatementReport()));
    } else if (title == 'Customer') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddCustomer()));
    } else if (title == 'View Loan') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchLoan()));
    } else if (title == 'View Customer') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GetCustomer()));
    }
  }
}
