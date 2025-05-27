import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/dashboard/dashboard.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Future<void> login({String? user, String? pwd}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> response = await ApiServices.post(
        slug: ApiConstant.LOGIN,
        body: {"user": user, "pwd": pwd, "apptoken": "ihiugyftdrsdgpyghfgfg"});
    if (response['success'] == true) {
      await prefs.setString('Scode', response['code']);
      await prefs.setString('Mfin', response['mfin']);
     await prefs.setBool('isLoggedIn', true);
      logger.e(response);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      Get.to(() => Dashboard());
    } else {
      logger.e(response);

      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }
}

Future<void> verifyOtp({String? mail, String? otp}) async {
  Map<String, dynamic> data = {"user": "otpverifed", "mail": mail, "otp": otp};
  Map<String, dynamic> response =
      await ApiServices.post(slug: ApiConstant.OTPVERIFICATION, body: data);
  if (response['success'] == true) {
    BotToast.showText(
      text: response['message'],
      contentColor: Colors.green.withOpacity(0.8),
      textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
    );
    logger.w(response);
  } else {
    BotToast.showText(
      text: response['message'],
      contentColor: Colors.red.withOpacity(0.8),
      textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
    );
    logger.w(response);
  }
}


//  import 'package:get/get.dart';
// import 'package:info_fina/const/global_const.dart';
// import 'package:info_fina/services/api_service.dart';

// class AuthController extends GetxController{
//   Future<void> login({String? user, String? pwd}) async {
//     Map<String,dynamic> response =ApiServices.post(slug: ApiConstant.LOGIN, body: body)
//   }
// }