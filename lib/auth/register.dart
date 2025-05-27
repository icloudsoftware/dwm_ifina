import 'dart:math';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:mailer/mailer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:info_fina/auth/otp_screen.dart';
import 'package:info_fina/controller/signup_controller.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final a = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final registration = Get.put(RegistrationController());
  bool? message;
  String generatedOTP = "";

  String generateOTP() {
    Random random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  Future<void> sendOTPEmail(
    String recipientEmail,
    BuildContext context,
  ) async {
    String username = "shanthamarai04@gmail.com";
    String password = "seub oqes gyil cogc";
    final smtpServer = gmail(username, password);
    generatedOTP = generateOTP();

    try {
      final result = await registration.registerUser(
          mobile: mobileController.value.text,
          email: recipientEmail,
          name: nameController.value.text,
          otp: generatedOTP,
          password: passwordController.value.text,
          username: usernameController.value.text,
          message: message);

      // Assuming result contains a 'message' field indicating success
      if (message = true) {
        final emailMessage = Message()
          ..from = Address(username, 'Infossel Collections')
          ..recipients.add(recipientEmail)
          ..subject = 'Your OTP Code'
          ..text =
              'Your OTP code is $generatedOTP. Do not share it with anyone.';

        await send(emailMessage, smtpServer);
        print("OTP Sent to Email: $generatedOTP");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("OTP sent to $recipientEmail"),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration failed. OTP not sent."),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      logger.w("Error during registration or email sending: $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Form(
              key: a,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "asset/logo.png",
                      height: 180,
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  buildTextField("Name", nameController, Icons.person,
                      validator: (names) {
                    if (names == null || names.isEmpty || names.length < 2) {
                      return "please enter valid name";
                    }
                  }),
                  SizedBox(height: 1.5.h),
                  buildTextField(
                      "Username", usernameController, Icons.person_outline,
                      validator: (user) {
                    if (user == null || user.isEmpty) {
                      return "Enter valid user name";
                    }
                    final username = RegExp(r"^[a-zA-Z0-9_-]+$");
                  }),
                  SizedBox(height: 1.5.h),
                  buildTextField("Password", passwordController, Icons.lock,
                      validator: (pass) {
                    if (pass == null || pass.isEmpty) {
                      return "Enter a valid input";
                    }
                  }, obscureText: true),
                  SizedBox(height: 1.5.h),
                  buildTextField("Confirm Password", confirmPasswordController,
                      validator: (confirmPass) {
                    if (confirmPass == null || confirmPass.isEmpty) {
                      return "Please confrim your password";
                    }
                    if (confirmPass != passwordController.text) {
                      return "Not the same";
                    }
                    return null;
                  }, Icons.lock_outline, obscureText: true),
                  SizedBox(height: 1.5.h),
                  buildTextField("Email ID", emailController, Icons.email,
                      validator: (mail) {
                    if (mail == null || mail.isEmpty) {
                      return "Enter a valid email";
                    }
                    final Emailid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!Emailid.hasMatch(mail)) {
                      return "Invalid email format";
                    }
                    return null;
                  }),
                  SizedBox(height: 1.5.h),
                  buildTextField("Mobile Number", mobileController, Icons.phone,
                      validator: (mobile) {
                    if (mobile == null || mobile.isEmpty) {
                      return "Enter your mobile number";
                    }
                    final mobileRegex = RegExp(r'^[0-9]{10}$');
                    if (!mobileRegex.hasMatch(mobile)) {
                      return "Enter a valid 10-digit number";
                    }
                    return null;
                  }, keyboardType: TextInputType.phone),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (a.currentState!.validate()) {
                          await sendOTPEmail(
                              emailController.value.text, context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPPage(
                                  name: nameController.value.text,
                                  email: emailController.value.text,
                                ),
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.indigo.shade700,
                        disabledForegroundColor: Colors.white.withOpacity(0.38),
                        disabledBackgroundColor:
                            Colors.white.withOpacity(0.12), // White text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String hintText, TextEditingController controller, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          prefixIcon: Icon(icon, color: Colors.indigo.shade700),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ));
  }
}
