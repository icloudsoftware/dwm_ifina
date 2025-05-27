import 'package:get/get.dart';
import '../const/global_const.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:info_fina/model/outstanding_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutStandingReportController extends GetxController {
  RxList<OutstandingReportModel> outstandReport =
      <OutstandingReportModel>[].obs;
  dynamic activeDaily;
  dynamic activeWeekly;
  dynamic activeMonthly;
  dynamic closedDaily;
  dynamic closedWeekly;
  dynamic closedMonthly;
  dynamic totalDaily;
  dynamic totalWeekly;
  dynamic totalMonthly;
  dynamic totalLoanAmountDaily;
  dynamic totalLoanAmountWeekly;
  dynamic totalAmountMonthly;
  dynamic activeLoandaily;
  dynamic activeLoanWeekly;
  dynamic activeLoanMonthly;

  Future<void> outstandingReportData(
      {String? fromDate, String? toDate, String? loanType}) async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "outstandingreport",
      "loantype": loanType,
      "mfin": mfin,
      "scode": scode,
      "fdate": fromDate,
      "tdate": toDate
    };
    logger.w('datas >> ${data}');
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.OUTSTANDINGREPORT, body: data);

    if (response['success']) {
      outstandReport.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => OutstandingReportModel.fromJson(json))
          .toList();

      logger.w(' ${response}');
    } else {
      logger.e(response);
    }
    // isLoading.value = false;
  }

  Future<void> statementReport({String? fdate, String? tdate}) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "statementreport",
      "mfin": mfin,
      "scode":scode,
      "fdate": fdate,
      "tdate": tdate
    };
    logger.e(data);
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.STATEMENTREPORT, body: data);
    if (response['success'] == true) {
      logger.e(response);
      closedDaily = response['data']['closed_count']['daily'];
      closedWeekly = response['data']['closed_count']['weekly'];
      closedMonthly = response['data']['closed_count']['monthly'];
      activeDaily = response['data']['active_count']['daily'];
      activeWeekly = response['data']['active_count']['weekly'];
      activeMonthly = response['data']['active_count']['monthly'];
      totalDaily = response['data']['tot_collected_sum']['daily'];
      totalWeekly = response['data']['tot_collected_sum']['weekly'];
      totalWeekly = response['data']['tot_collected_sum']['monthly'];
      totalLoanAmountDaily = response['data']['closed_sum']['daily'];
      totalLoanAmountWeekly = response['data']['closed_sum']['weekly'];
      totalAmountMonthly = response['data']['closed_sum']['monthly'];
      activeLoandaily = response['data']['active_sum']['daily'];
      activeLoandaily = response['data']['active_sum']['weekly'];
      activeLoandaily = response['data']['active_sum']['monthly'];
    } else {
      logger.e(response);
    }
  }
}
