import 'package:get/get.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/model/loans_model.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  Rx<Loans> loansDetail = Loans().obs;
  var isLoading = false.obs;
  Future<void> dahboardCount({String? user}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');

    // isLoading.value = true;
    Map<String, dynamic> response = await ApiServices.post(
      slug: ApiConstant.DASHBOARDCOUNT,
      body: {"user": user, "mfin": mfin},
    );

    if (response['success'] == true) {
      if (response['loans'] != null) {
        loansDetail.value = Loans.fromJson(response['loans']);
        logger.e(response);
      } else {
        logger.w('No data found in response');
      }
      logger.e(response);
    } else {
      logger.w('Request failed');
    }
    // isLoading.value = false;
  }
}
