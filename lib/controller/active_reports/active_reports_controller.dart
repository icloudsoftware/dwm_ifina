import 'dart:convert';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../const/global_const.dart';
import '../../services/api_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/model/customer_model.dart';
import 'package:info_fina/model/fullview_model.dart';
import 'package:info_fina/model/bill_view_model.dart';
import 'package:info_fina/model/active_mc_model.dart';
import 'package:info_fina/model/active_wc_model.dart';
import 'package:info_fina/model/active_dc_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveReportsController extends GetxController {
  Map<String, dynamic>? datas;
  RxList<ActiveReportDcModel> activeReportDc = <ActiveReportDcModel>[].obs;
  RxList<ActiveReportWcModel> activeReportWc = <ActiveReportWcModel>[].obs;
  RxList<ActiveReportMcModel> activeReportMc = <ActiveReportMcModel>[].obs;
  RxList<FullViewModel> fullviewData = <FullViewModel>[].obs;
  RxList<CustomerModel> customerData = <CustomerModel>[].obs;
  RxList<BillViewModel> billList = <BillViewModel>[].obs;

  var isLoading = false.obs;
  Future<void> activeReportDcData({
    String? fromDate,
    String? toDate,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');

    Map<String, dynamic> data = {
      "user": "activereportdc",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.ACTIVEREPORTDC, body: data);

    if (response['success']) {
      activeReportDc.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => ActiveReportDcModel.fromJson(json))
          .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> activeReportwcData({
    String? fromDate,
    String? toDate,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "activereportwc",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.ACTIVEREPORTWC, body: data);

    if (response['success']) {
      activeReportWc.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => ActiveReportWcModel.fromJson(json))
          .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> activeReportMcData({
    String? fromDate,
    String? toDate,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "activereportm",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.ACTIVEREPORTMC, body: data);

    if (response['success']) {
      activeReportMc.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => ActiveReportMcModel.fromJson(json))
          .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> fullView({
    String? hpl,
    String? loanType,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    isLoading.value = true;
    Map<String, dynamic> data = {
      "user": "fullview",
      "hpl": hpl,
      "loantype": loanType,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.FULLVIEWLOAN, body: data);

    if (response['success']) {
      fullviewData.value =
          List<Map<String, dynamic>>.from(response['result']['due_data'])
              .map((json) => FullViewModel.fromJson(json))
              .toList();
      customerData.value =
          List<Map<String, dynamic>>.from(response['result']['customer'])
              .map((e) => CustomerModel.fromJson(e))
              .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    isLoading.value = false;
  }

  Future<void> billReport(
      {String? loantype, String? fdate, String? tdate}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "billreport",
      "loantype": loantype,
      "fdate": fdate,
      "tdate": tdate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.BILLREPORT, body: data);
    if (response['success']) {
      logger.e(response);
      billList.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => BillViewModel.fromJson(json))
          .toList();
    } else {
      logger.e(response);
    }
  }

  Future<void> settlementAmount({String? user, String? hpl}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": user,
      "hpl": hpl,
      "scode": scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.SETTLEMENTAMOUNT, body: data);
    if (response['success'] == true) {
      logger.e(response);

      datas = response;
    } else {
      logger.w(response);
    }
  }

  Future<void> makeReceipt({String? user, String? hpl, String? payment}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": user,
      "hpl": hpl,
      "payment": payment,
      'scode': scode,
      "mfin": mfin
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.MAKERECEIPT, body: data);
    if (response['success'] == true) {
      logger.e(response);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    } else {
      logger.w(response);
      BotToast.showText(
        text: response['message'],
        contentColor: Colors.red.withOpacity(0.8),
        textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      );
    }
  }

  Future<void> submitsett({
    required String loanType,
    required String hpl,
    required String payment,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    final int paymentAmount = int.tryParse(payment) ?? 0;

    final Map<String, dynamic> data = {
      "user": loanType,
      "hpl": hpl,
      "payment": paymentAmount,
      "mfin": mfin,
      "scode": scode,
    };

    try {
      final response =
          await ApiServices.post(slug: ApiConstant.SETTLEMENT, body: data);

      logger.w(response);

      if (response['success'] == true) {
        BotToast.showText(
          text: response['message'],
          contentColor: Colors.green.withOpacity(0.8),
          textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
        );
      } else {
        BotToast.showText(
          text: response['message'],
          contentColor: Colors.red.withOpacity(0.8),
          textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
        );
      }
    } catch (e) {
    } finally {}
  }
}
