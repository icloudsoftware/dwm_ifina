// import 'dart:async';
// import 'package:sizer/sizer.dart';
// import 'package:flutter/material.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityService {
//   static final ConnectivityService _instance = ConnectivityService._internal();
//   factory ConnectivityService() => _instance;

//   ConnectivityService._internal();

//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _subscription;
//   bool _isOffline = false;

//   void initialize() {
//     _subscription = _connectivity.onConnectivityChanged.listen((results) {
//       final hasConnection =
//           results.any((result) => result != ConnectivityResult.none);

//       if (!hasConnection && !_isOffline) {
//         _isOffline = true;
//         BotToast.showText(
//           text: 'No Internet.check connectivity',
//           contentColor: Colors.red.withOpacity(0.8),
//           textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
//         );
//       } else if (hasConnection && _isOffline) {
//         _isOffline = false;
//           BotToast.showText(
//           text: 'No Internet.check connectivity',
//           contentColor: Colors.green.withOpacity(0.8),
//           textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
//         );
//       }
//     });
//   }

//   void dispose() {
//     _subscription.cancel();
//   }
// }
