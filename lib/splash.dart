import 'dart:async';
import 'package:info_fina/view.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/auth/Login.dart';
import 'package:info_fina/dashboard/dashboard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isLoggedIn = await prefs.getBool('isLoggedIn');

      if (isLoggedIn == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),

          Container(
            child: Image.asset(
              "asset/logo.png",
              height: 300,
              width: 800,
              fit: BoxFit.contain,
            ),
          ),

          // Icon(Icons.account_balance_wallet, size: 100, color: Colors.white),

          SizedBox(height: 3),

          SpinKitWave(color: Colors.indigo.shade900, size: 50),

          SizedBox(height: 20),

          Text(
            "Smart Collections",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),

          SizedBox(height: 5),

          Text(
            "Manage your daily & weekly transactions",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
