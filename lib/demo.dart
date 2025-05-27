import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
// // import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

// class LoanController extends GetxController {
//   var isLoading = false.obs;

//   Future<void> createLoan() async {
//     isLoading.value = true;

//     try {
//       // Get current location
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       var url =
//           Uri.parse('http://162.215.218.106/~ifina/daily/api/createloan.php');

//       var body = {
//         "user": "monthly",
//         "loantype": "monthly",
//         "totalhpamt": 10000,
//         "interest": 200,
//         "inter": 24,
//         "hpamount": 8500,
//         "duemnt": 12,
//         "dueamt": 1000,
//         "name": "rajesh",
//         "pno": "9600219321",
//         "area": "avarampalayam",
//         "model": "line",
//         "lat": position.latitude.toString(),
//         "lang": position.longitude.toString(),
//         "vno": "41654184841",
//         "mfin": "ramu",
//         "scode": "ramu"
//       };

//       var response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         Get.snackbar("Success", jsonData.toString());
//       } else {
//         Get.snackbar("Error", "Failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// class CreateLoan2 extends StatelessWidget {
//   final LoanController controller = Get.put(LoanController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Create Loan")),
//         body: Center(
//           child: Obx(() {
//             return controller.isLoading.value
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: () {
//                       controller.createLoan();
//                     },
//                     child: Text("Create Loan"),
//                   );
//           }),
//         ));
//   }
// }

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   final TextEditingController latController = TextEditingController();
//   final TextEditingController lngController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     // Check for permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied.');
//     }

//     // Get current position
//     Position position = await Geolocator.getCurrentPosition();
//     latController.text = position.latitude.toString();
//     lngController.text = position.longitude.toString();
//   }

//   @override
//   void dispose() {
//     latController.dispose();
//     lngController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Current Location")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: latController,
//               readOnly: true,
//               decoration: InputDecoration(labelText: 'Latitude'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: lngController,
//               readOnly: true,
//               decoration: InputDecoration(labelText: 'Longitude'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
