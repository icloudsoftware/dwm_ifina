import 'dart:convert';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/model/line_model.dart';
import 'package:info_fina/model/search_model.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:info_fina/model/view_loan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_fina/sucess_screen/success_screen.dart';
import 'package:info_fina/model/fullview_customer_model.dart';


class CreateLoanController extends GetxController {
  RxList<LineModel> lineList = <LineModel>[].obs;
  RxList<FullViewCustomerModel> customerDetails = <FullViewCustomerModel>[].obs;
  var isLopading = false.obs;
  RxList<ViewLoanModel> viewLoanModel = <ViewLoanModel>[].obs;
  RxList<searchModel> searchLoan = <searchModel>[].obs;

  Map<String, List<String>> lineAreaData = {};
  List<String> areaList = [];
  Future<void> createWeeklyLoan({required Map<String, dynamic> data}) async {
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.WEEKLYCOLLECTIONS, body: data);
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

  Future<void> createMonthlyLoan({required Map<String, dynamic> data}) async {
    Map<String, dynamic> response = await ApiServices.post(
        slug: ApiConstant.MONTHLYCOLLECTIONS, body: data);
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

  Future<void> createLine(
      {String? name, String? loanType, String? badDays}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "createline",
      "name": name,
      'loantype': loanType,
      "baddebt": badDays,
      "mfin": mfin,
      "scode": scode
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CREATELINE, body: data);
    if (response['success']) {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.e(response);
    } else {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.w(response);
    }
  }

  Future<void> createArea({String? line, String? area}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "createarea",
      "name": line,
      "mfin": mfin,
      "scode": scode,
      "area": area
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CREATEAREA, body: data);
    if (response['success']) {
      logger.e(response);
      BotToast.showText(
        text: response['message'],
        
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.e(response);
    } else {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.w(response);
    }
  }

  Future<void> getLines() async {
    Map<String, dynamic> data = {"user": "lines"};
    logger.w(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.GETLINES, body: data);
    if (response['success']) {
      logger.e(response['message']);
      logger.e(response);
      lineList.value = List<Map<String, dynamic>>.from(response['subarea'])
          .map((json) => LineModel.fromJson(json))
          .toList();
      logger.e(response);
    } else {
      logger.w(response['message']);
    }
  }

  Future<void> getArea({String? line}) async {
    Map<String, dynamic> data = {"user": "getarea", 'line': line};
    logger.w(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.GETAREA, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      areaList = List<String>.from(response['areas']).toSet().toList();
      logger.e(response);
    } else {
      logger.w(response['message']);
    }
  }

  Future<void> createLoan({required Map<String, dynamic> data}) async {
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CREATELOAN, body: data);
    if (response['success']) {
      Get.to(() => SuccessScreen(
            success: 1,
          ));
      logger.e(response);
    } else {
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
      logger.w(response);
    }
  }

  Future<void> viewLoan({
    String? fdate,
    String? tdate,
    String? loantype,
  }) async {
    isLopading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "viewloan",
      "fdate": fdate,
      "tdate": tdate,
      "loantype": loantype,
      "mfin": mfin,
      "scode": scode
    };
    logger.w(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.VIEWLOAN, body: data);
    if (response['success']) {
      logger.e(response['message']);
      viewLoanModel.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => ViewLoanModel.fromJson(json))
          .toList();
      logger.e(response);
    } else {
      logger.w(response['message']);
    }
    isLopading.value = false;
  }

  Future<void> fetchLineAreaData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    try {
      Map<String, dynamic> response = await ApiServices.post(
        slug: ApiConstant.ALLAREA,
        body: {"user": "allareas", "mfin": mfin, "scode": scode},
      );

      if (response['success'] == true) {
        logger.w(response);

        final data = response['data'] as Map<String, dynamic>;

        // Convert each value in the map to List<String>
        lineAreaData = data.map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        );

        // Refresh UI if inside a StatefulWidget
      } else {
        // Handle API failure
        logger.e("API returned success: false");
      }
    } catch (e) {
      logger.e("Error fetching line area data: $e");
    }
  }

  Future<void> deletLine({String? line}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "deleteline",
      "name": line,
      "scode": scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.DELETELINE, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }

  Future<void> deleteArea({String? line, String? area}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "deleteline",
      "name": line,
      "area": area,
      "scode": scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.DELETEAREA, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }

  Future<void> fullViewCustomer({
    String? hpl,
    String? loanType,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    isLopading.value = true;
    Map<String, dynamic> data = {
      "user": "fullview",
      "hpl": hpl,
      "loantype": loanType,
      "scode": scode,
      "mfin": mfin
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.FULLVIEW, body: data);

    if (response['success']) {
      customerDetails.value =
          List<Map<String, dynamic>>.from(response['result']['customer'])
              .map((json) => FullViewCustomerModel.fromJson(json))
              .toList();

      logger.w('customerDetails>> ${response}');
    } else {
      logger.e(response);
    }
    isLopading.value = false;
  }

  Future<void> deleteCustomer({String? id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "Custdelete",
      "id": id,
      "scode": scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.DELETECUSTOMER, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }

  Future<void> deleteLoan({String? id, String? loantype}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "loandelete",
      "id": id,
      "loantype": loantype,
      "scode": scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.DELETELOAN, body: data);
    if (response['success'] == true) {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.e(response['message']);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }

  Future<void> search() async {
    Map<String, dynamic> data = {
      "user": "yes",
      "hpl": "1",
      "pno": "",
      "area": "",
      "name": "",
      "line": "",
      "scode": "ramu",
      "mfin": "ramu"
    };
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.SEARCHAPI, body: data);
  }
}
