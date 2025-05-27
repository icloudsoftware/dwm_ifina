import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';

class PreProcessingController extends GetxController {
  Future<void> preProcessingLoan({required Map<String, dynamic> data}) async {
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.PRELOANPROCESSING, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green,
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red,
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.e(response['message']);
    }
  }
}
