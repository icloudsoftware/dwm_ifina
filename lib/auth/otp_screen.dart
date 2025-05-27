import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:info_fina/controller/otp_controller.dart';

class OTPPage extends StatefulWidget {
  final String name;
  final String email;

  const OTPPage({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final Otp = Get.put(OtpController());

  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    otpFocusNode.addListener(() {
      if (otpFocusNode.hasFocus) {
        print("OTP field focused");
      } else {
        print("OTP field unfocused");
      }
    });
  }

  @override
  void dispose() {
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
        title: Text(
          'OTP Verification',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
         
          children: [
            Image.asset('asset/otp.jpg',height:34.h,),
            SizedBox(height: 3.h),
      
            Text(
              "Hi ${widget.name},",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
      
            Text(
              "OTP has been sent to your registered email address.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
      
            // OTP input field with focus handling
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: otpController,
                focusNode: otpFocusNode, // Attach the FocusNode
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 3.h),
      
            // Submit Button
            ElevatedButton(
              onPressed: () async {
              await Otp.verifyOtp(mail:widget.email,otp: otpController.value.text);
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      )
    );
  }
}