import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/Create_loan.dart';
import 'package:info_fina/line_view/line_list.dart';
import 'package:info_fina/view_areas/view_areas.dart';
import 'package:info_fina/collections/collections.dart';
import 'package:info_fina/add_customer/add_customer.dart';
import 'package:info_fina/CustomersList/customer_search.dart';
import 'package:info_fina/collection_search/collection_search.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool _showCollectionNew = false;

  final List<Widget> _screens = [
    LinePage(),
    ViewAreas(),
    AddCustomer(
      isback: false,
    ),
    SearchCustomers()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showCollectionNew = false; // Hide collection screen when changing tabs
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

  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showCollectionNew) {
          setState(() {
            _showCollectionNew = false;
          });
          return false;
        }

        final now = DateTime.now();
        if (_lastBackPressed == null ||
            now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
          _lastBackPressed = now;
          BotToast.showText(
            text: 'Press back again to exit',
            contentColor: Colors.black.withOpacity(0.6),
            textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
          );
          return false;
        }
        return true; // Exit the app
      },
      child: MediaQuery.removeViewInsets(
        removeBottom: true,
        context: context,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
              ? collectionSearch()
              : _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.indigo.shade900,
            type: BottomNavigationBarType.fixed,
            items: [
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
        ),
      ),
    );
  }
}
