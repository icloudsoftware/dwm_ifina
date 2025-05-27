import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';

class RegistrationController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var registrationResponse = {}.obs;

  Future<void> registerUser(
      {required String name,
      required String username,
      required String email,
      required String password,
      required String otp,
      required String mobile,
      bool? message}) async {
    isLoading(true); // Start loading

    Map<String, dynamic> body = {
      "user": "singup",
      "name": name,
      "username": username,
      "mail": email,
      "pwd": password,
      "otp": otp,
      "mno": mobile
    };

    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.SIGNUP, body: body);
    logger.w(body);
    if (response['success'] == true) {
      logger.w(response);
      message = response['success'];
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.e(response);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }

    isLoading(false);
  }
}
