import 'package:get/get.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:info_fina/model/closed_loans_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClosedLoansController extends GetxController {
  RxList<closedLoansDcModel> closedLoansData = <closedLoansDcModel>[].obs;
  Future<void> closdeLoansDc({
    String? fromDate,
    String? toDate,
  }) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "closedloanreportdc",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CLOSEDLOANDDC, body: data);

    if (response['success']) {
      closedLoansData.value =
          List<Map<String, dynamic>>.from(response['result'])
              .map((json) => closedLoansDcModel.fromJson(json))
              .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> closdeLoansWc({
    String? fromDate,
    String? toDate,
  }) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "closedloanreportwc",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CLOSEDLOANSWC, body: data);

    if (response['success']) {
      closedLoansData.value =
          List<Map<String, dynamic>>.from(response['result'])
              .map((json) => closedLoansDcModel.fromJson(json))
              .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> closdeLoansMc({
    String? fromDate,
    String? toDate,
  }) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "closedloanreportm",
      "fdate": fromDate,
      "tdate": toDate,
      "mfin": mfin,
      "scode": scode
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.CLOSEDLOANSMC, body: data);

    if (response['success']) {
      closedLoansData.value =
          List<Map<String, dynamic>>.from(response['result'])
              .map((json) => closedLoansDcModel.fromJson(json))
              .toList();

      logger.w('subareas>> ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }
}
