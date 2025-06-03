import 'dart:ui';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:info_fina/model/today_dues_model.dart';
import 'package:info_fina/model/customer_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_fina/sucess_screen/success_screen.dart';

class CreateCostomerController extends GetxController {
  RxList<TodayDuesModel> duesModelData = <TodayDuesModel>[].obs;

  RxList<CustomerListModel> customerListData = <CustomerListModel>[].obs;
  int? custid;
  Future<void> addcustomer(
      {required Map<String, dynamic> data, bool? message}) async {
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.ADDCUSTOMER, body: data);
    if (response['success']) {
      Get.to(() => SuccessScreen(
            success: 2,
          ));
      message = response['success'];
      logger.e(response);

      print("customer added successfully");
    } else {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.w(response);
      print("Failed to add costomer");
    }
  }

  Future<void> todayDues({String? date, String? line, String? area}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = prefs.getString('Scode');
    var mfin = prefs.getString('Mfin');

    Map<String, dynamic> data = {
      "user": "paydues",
      "duedate": date,
      "line": line,
      "area": area,
      "mfin": mfin,
      "scode": scode,
    };

    logger.e(data);

    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.TODAYDUES, body: data);

    if (response['success'] == true) {
      logger.e(response);
      duesModelData.value =
          List<Map<String, dynamic>>.from(response['result']['loans'])
              .map((json) => TodayDuesModel.fromJson(json))
              .toList();
    } else {
      logger.e(response['message']);
    }
  }

  Future<void> getCusId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> response = await ApiServices.post(
        slug: ApiConstant.CUSTOMERID,
        body: {"user": "customerid", "mfin": mfin, "scode": scode});
    if (response['success']) {
      custid = response['cid'];
      logger.e(response);
    } else {
      logger.e(response['message']);
    }
  }

  Future<void> getCustomers({String? line, String? area}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "listcust",
      "line": line,
      "area": area,
      "mfin": mfin,
      "scode": scode
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CUSTOMERLIST, body: data);
    if (response['success']) {
      customerListData.value =
          List<Map<String, dynamic>>.from(response['result'])
              .map((json) => CustomerListModel.fromJson(json))
              .toList();
      logger.w(response);
    } else {
      logger.e(response);
    }
  }
}
